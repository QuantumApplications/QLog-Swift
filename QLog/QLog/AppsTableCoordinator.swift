//
//  AppsTableCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 16.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation

/// Coordinates handling of apps table
class AppsTableCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let appsTableViewController: AppsTableViewController
    private let apps: [URL]

    private var logsTableCoordinator: LogsTableCoordinator?

    /**
     Returns an array of application target URLS
     - returns: The array of application target URLS
     */
    private static func getApps() -> [URL] {
        let logUrl = UiLogger.shared.logUrl
        return (try? FileManager.default.contentsOfDirectory(at: logUrl, includingPropertiesForKeys: nil, options: []).filter { $0.hasDirectoryPath }) ?? []
    }

    /**
     Creates a new apps table coordinator
     - parameter navigationController: The navigation controller to use
     */
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.appsTableViewController = AppsTableViewController()
        self.apps = AppsTableCoordinator.getApps()
        self.appsTableViewController.apps = self.apps
        self.appsTableViewController.delegate = self
    }

    func start() {
        self.navigationController.navigationBar.topItem?.title = QLog.Texts.archive
        self.appsTableViewController.tabBarItem = UITabBarItem(title: QLog.Texts.archive, image: QLog.Images.archive, tag: 2)
        self.navigationController.pushViewController(self.appsTableViewController, animated: true)
    }

}

// MARK: - AppsTableViewControllerDelegate

extension AppsTableCoordinator: AppsTableViewControllerDelegate {

    /**
     Dismisses the view controller
     */
    func back() {
        UiLogger.shared.shown = false
        self.appsTableViewController.dismiss(animated: true, completion: nil)
    }

    /**
     Sets the logs table coordinator for the given app URL
     and starts the coordinator
     - parameter app: The app URL
     */
    func show(_ app: URL) {
        self.logsTableCoordinator = LogsTableCoordinator(navigationController: self.navigationController, app: app)
        self.logsTableCoordinator?.start()
    }

}
