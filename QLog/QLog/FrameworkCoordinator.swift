//
//  FrameworkCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 20.09.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit
import Zip

class FrameworkCoordinator: RootViewCoordinator {

    var liveLogViewController = LiveLogViewController()

    var rootViewController: UIViewController {
        return self.tabbarController
    }
    var shown = false

    private lazy var tabbarController: UITabBarController = {
        let tabBarController = UITabBarController()
        return tabBarController
    }()

    init() {
        self.addLogViewController()
        self.addArchiveViewController()
        self.addSupportPackageViewController()
    }

    func start() {
        guard !self.shown else {
            return
        }
        self.shown = true
        UIApplication.topViewController()?.present(self.rootViewController, animated: true, completion: nil)
    }

    private func addLogViewController() {
        let viewController = self.liveLogViewController
        viewController.delegate = self
        self.addViewController(viewController: viewController, title: QLog.Texts.live)
    }

    private func addArchiveViewController() {
        let viewController = AppsTableViewController()
        viewController.delegate = self
        self.addViewController(viewController: viewController, title: QLog.Texts.archive)
    }

    private func addSupportPackageViewController() {
        let viewController = SupportPackageViewController()
        viewController.delegate = self
        self.addViewController(viewController: viewController, title: QLog.Texts.supportPackage)
    }

    private func addViewController(viewController: UIViewController, title: String) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.topItem?.title = title
        var viewControllers = self.tabbarController.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        self.tabbarController.viewControllers = viewControllers
    }

}

// MARK: - LogViewControllerDelegate

/// Needs to be global, otherwise the controller will be destroyed when the file is handed over to target application
var documentInteractionController: UIDocumentInteractionController!

extension FrameworkCoordinator: LiveLogViewControllerDelegate {

    func back(_ liveLogViewController: LiveLogViewController) {
        self.shown = false
        liveLogViewController.dismiss(animated: true, completion: nil)
    }

    func action(_ liveLogViewController: LiveLogViewController, sender: UIBarButtonItem) {
        // Get attributed text
        guard let text = liveLogViewController.textView.attributedText else {
            return
        }
        // Convert attributed text to HTML
        let documentAttributes = [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html]
        let htmlData = (try? text.data(from: NSRange(location: 0, length: text.length), documentAttributes: documentAttributes)) ?? Data()
        // Save HTML to file
        let tempDirectory = NSTemporaryDirectory() as NSString
        let tempFilePath = tempDirectory.appendingPathComponent("log.htm")
        // Delete old file if existing
        if FileManager.default.fileExists(atPath: tempFilePath) {
            try? FileManager.default.removeItem(atPath: tempFilePath)
        }
        FileManager.default.createFile(atPath: tempFilePath, contents: htmlData, attributes: nil)
        // Share HTML file
        documentInteractionController = UIDocumentInteractionController()
        documentInteractionController.url = URL(fileURLWithPath: tempFilePath)
        documentInteractionController.uti = String(kUTTypeHTML)
        documentInteractionController.presentOptionsMenu(from: sender, animated: true)
    }

}

// MARK: - AppsTableViewControllerDelegate

extension FrameworkCoordinator: AppsTableViewControllerDelegate {

    func back(_ appsTableViewController: AppsTableViewController) {
        self.shown = false
        appsTableViewController.dismiss(animated: true, completion: nil)
    }

    func show(_ appsTableViewController: AppsTableViewController, app: URL) {
        let logsTableViewController = LogsTableViewController()
        logsTableViewController.app = app
        appsTableViewController.show(logsTableViewController, sender: appsTableViewController)
    }

}

// MARK: - SupportPackageViewControllerDelegate

extension FrameworkCoordinator: SupportPackageViewControllerDelegate {

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    static let targetName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Application"

    func back(_ supportPackageViewController: SupportPackageViewController) {
        self.shown = false
        supportPackageViewController.dismiss(animated: true, completion: nil)
    }

    func generateSupportPackage(_ supportPackageViewController: SupportPackageViewController) {
        // Zip log files
        let zipDirectoryUrl = URL(fileURLWithPath: NSTemporaryDirectory())
        let zipFileUrl = zipDirectoryUrl.appendingPathComponent("Support Package \(FrameworkCoordinator.targetName) \(FrameworkCoordinator.dateFormatter.string(from: Date())).zip")
        let logPathUrl = UiLogger.getShared().logUrl
        guard (try? Zip.zipFiles(paths: [logPathUrl], zipFilePath: zipFileUrl, password: nil, progress: { progress in
            print(progress)
        })) != nil else {
            return
        }
        // Share zip file
        documentInteractionController = UIDocumentInteractionController()
        documentInteractionController.url = zipFileUrl
        documentInteractionController.uti = String(kUTTypeZipArchive)
        documentInteractionController.presentOptionsMenu(from: liveLogViewController.view.frame, in: liveLogViewController.view, animated: true)
    }

}
