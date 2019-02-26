//
//  LogsTableCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 19.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation

class LogsTableCoordinator: Coordinator {

    private var archiveLogCoordinator: ArchiveLogCoordinator?
    private let navigationController: UINavigationController
    private let logsTableViewController: LogsTableViewController
    private let app: URL
    private let logs: [URL]

    init(navigationController: UINavigationController, app: URL) {
        self.navigationController = navigationController
        self.app = app
        self.logs = (try? FileManager.default.contentsOfDirectory(at: self.app, includingPropertiesForKeys: nil, options: []).filter { !$0.hasDirectoryPath }) ?? []
        self.logsTableViewController = LogsTableViewController()
        self.logsTableViewController.title = self.app.lastPathComponent
        self.logsTableViewController.logs = self.logs
        logsTableViewController.delegate = self
    }

    func start() {
        self.navigationController.pushViewController(self.logsTableViewController, animated: true)
    }

}

// MARK: - AppsTableViewControllerDelegate

extension LogsTableCoordinator: LogsTableViewControllerDelegate {

    func didSelect(_ log: URL) {
        self.archiveLogCoordinator = ArchiveLogCoordinator(navigationController: self.navigationController, log: log)
        self.archiveLogCoordinator?.start()
    }

}
