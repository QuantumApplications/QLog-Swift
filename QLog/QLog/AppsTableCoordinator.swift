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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.appsTableViewController = AppsTableViewController()
        appsTableViewController.delegate = self
    }

    func start() {
        self.navigationController.navigationBar.topItem?.title = QLog.Texts.archive
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
