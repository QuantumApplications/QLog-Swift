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

class FrameworkCoordinator: RootViewCoordinator {

    let logViewController = LogViewController(cancelButton: true)

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
        let viewController = self.logViewController
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.topItem?.title = QLog.Texts.live
        var viewControllers = self.tabbarController.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        self.tabbarController.viewControllers = viewControllers
    }

    private func addArchiveViewController() {
        let viewController = AppsTableViewController()
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.topItem?.title = QLog.Texts.archive
        var viewControllers = self.tabbarController.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        self.tabbarController.viewControllers = viewControllers
    }

    private func addSupportPackageViewController() {
        let viewController = SupportPackageViewController()
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.topItem?.title = QLog.Texts.supportPackage
        var viewControllers = self.tabbarController.viewControllers ?? [UIViewController]()
        viewControllers.append(navigationController)
        self.tabbarController.viewControllers = viewControllers
    }

}

// MARK: - LogViewControllerDelegate

/// Needs to be global, otherwise the controller will be destroyed when the file is handed over to target application
var documentInteractionController: UIDocumentInteractionController!

extension FrameworkCoordinator: LogViewControllerDelegate {

    func back(_ logViewController: LogViewController) {
        self.shown = false
        logViewController.dismiss(animated: true, completion: nil)
    }

    func action(_ logViewController: LogViewController, sender: UIBarButtonItem) {
        // Get attributed text
        guard let text = logViewController.textView.attributedText else {
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

}

// MARK: - SupportPackageViewControllerDelegate

extension FrameworkCoordinator: SupportPackageViewControllerDelegate {

    func back(_ supportPackageViewController: SupportPackageViewController) {
        self.shown = false
        supportPackageViewController.dismiss(animated: true, completion: nil)
    }

}
