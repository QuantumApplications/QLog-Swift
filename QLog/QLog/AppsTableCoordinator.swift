//
//  AppsTableCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 16.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation

class AppsTableCoordinator: Coordinator {

    private var logsTableCoordinator: LogsTableCoordinator?
    private let navigationController: UINavigationController
    private let appsTableViewController: AppsTableViewController
    private let apps: [URL]

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        if let logUrl = UiLogger.shared?.logUrl {
            self.apps = (try? FileManager.default.contentsOfDirectory(at: logUrl, includingPropertiesForKeys: nil, options: []).filter { $0.hasDirectoryPath }) ?? []
        } else {
            self.apps = []
        }
        self.appsTableViewController = AppsTableViewController()
        self.appsTableViewController.apps = self.apps
        appsTableViewController.delegate = self
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
