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

    let appsTableCoordinator: AppsTableCoordinator
    let liveLogCoordinator: LiveLogCoordinator

    var rootViewController: UIViewController {
        return self.tabbarController
    }

    private lazy var tabbarController: UITabBarController = {
        let tabBarController = UITabBarController()
        return tabBarController
    }()

    init() {
        let liveLogNavigationController = UINavigationController()
        self.liveLogCoordinator = LiveLogCoordinator(navigationController: liveLogNavigationController)
        liveLogCoordinator.start()

        let appsTableNavigationController = UINavigationController()
        self.appsTableCoordinator = AppsTableCoordinator(navigationController: appsTableNavigationController)
        appsTableCoordinator.start()

        self.tabbarController.viewControllers = [liveLogNavigationController, appsTableNavigationController]

        self.addSupportPackageViewController()
    }

    func start() {
        UIApplication.topViewController()?.present(self.rootViewController, animated: true, completion: nil)
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

// MARK: - SupportPackageViewControllerDelegate

extension FrameworkCoordinator: SupportPackageViewControllerDelegate {

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    static let targetName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Application"

    func back(_ supportPackageViewController: SupportPackageViewController) {
        UiLogger.shared?.shown = false
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
        //documentInteractionController.presentOptionsMenu(from: liveLogViewController.view.frame, in: liveLogViewController.view, animated: true)
    }

}
