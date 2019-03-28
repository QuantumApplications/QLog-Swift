//
//  SupportPackageCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 17.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation

/// Coordinates handling of support packages
class SupportPackageCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let supportPackageViewController: SupportPackageViewController

    /**
     Creates a new support package coordinator
     - parameter navigationController: The navigation controller to use
     */
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.supportPackageViewController = SupportPackageViewController()
        self.supportPackageViewController.delegate = self
    }

    func start() {
        self.navigationController.navigationBar.topItem?.title = QLog.Texts.supportPackage
        self.supportPackageViewController.tabBarItem = UITabBarItem(title: QLog.Texts.supportPackage, image: QLog.Images.supportPackage, tag: 3)
        self.navigationController.pushViewController(self.supportPackageViewController, animated: true)
    }

}

// MARK: - SupportPackageViewControllerDelegate

extension SupportPackageCoordinator: SupportPackageViewControllerDelegate {

    /**
     Dismisses the view controller
     */
    func back() {
        UiLogger.shared.shown = false
        self.supportPackageViewController.dismiss(animated: true, completion: nil)
    }

    /**
     Compresses and archives all log files
     and presents the document interaction dialog to handle the ZIP file
     */
    func generateSupportPackage() {
        QLog.generateSupportPackage(viewController: self.supportPackageViewController)
    }

}
