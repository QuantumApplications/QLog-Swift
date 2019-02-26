//
//  AppsTableCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 16.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation

class AppsTableCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let appsTableViewController: AppsTableViewController
    private let apps: [URL]

    private var logsTableCoordinator: LogsTableCoordinator?

    private static func getApps() -> [URL] {
        guard let logUrl = UiLogger.shared?.logUrl else {
            return []
        }
        return (try? FileManager.default.contentsOfDirectory(at: logUrl, includingPropertiesForKeys: nil, options: []).filter { $0.hasDirectoryPath }) ?? []
    }

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

    func back() {
        UiLogger.shared?.shown = false
        self.appsTableViewController.dismiss(animated: true, completion: nil)
    }

    func show(_ app: URL) {
        self.logsTableCoordinator = LogsTableCoordinator(navigationController: self.navigationController, app: app)
        self.logsTableCoordinator?.start()
    }

}
