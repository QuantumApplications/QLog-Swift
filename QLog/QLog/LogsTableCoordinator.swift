//
//  LogsTableCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 19.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation

class LogsTableCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let logsTableViewController: LogsTableViewController
    private let app: URL

    init(navigationController: UINavigationController, app: URL) {
        self.navigationController = navigationController
        self.app = app
        self.logsTableViewController = LogsTableViewController()
        self.logsTableViewController.app = self.app
        //logsTableViewController.delegate = self
    }

    func start() {
        self.navigationController.show(self.logsTableViewController, sender: nil)
    }

}
