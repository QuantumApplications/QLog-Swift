//
//  LogsTableCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 19.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation

/// Coordinates handling of logs table
class LogsTableCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let logsTableViewController: LogsTableViewController
    /// The selected application target
    private let app: URL
    private let logs: [URL]

    private var archiveLogCoordinator: ArchiveLogCoordinator?

    /**
     Returns an array of log file URLS for a given application target URL
     - parameter app: The application target URL
     - returns: The array of log file URLs
     */
    private static func getLogs(_ app: URL) -> [URL] {
        return (try? FileManager.default.contentsOfDirectory(at: app, includingPropertiesForKeys: nil, options: []).filter { !$0.hasDirectoryPath }) ?? []
    }

    /**
     Creates a new logs table coordinator
     - parameter navigationController: The navigation controller to use
     */
    init(navigationController: UINavigationController, app: URL) {
        self.navigationController = navigationController
        self.logsTableViewController = LogsTableViewController()
        self.app = app
        self.logs = LogsTableCoordinator.getLogs(self.app)
        self.logsTableViewController.title = self.app.lastPathComponent
        self.logsTableViewController.logs = self.logs
        self.logsTableViewController.delegate = self
    }

    func start() {
        self.navigationController.pushViewController(self.logsTableViewController, animated: true)
    }

}

// MARK: - LogsTableViewControllerDelegate

extension LogsTableCoordinator: LogsTableViewControllerDelegate {

    /**
     Sets the archive log coordinator for the given log file URL
     and starts the coordinator
     - parameter log: The log file URL
     */
    func didSelect(_ log: URL) {
        self.archiveLogCoordinator = ArchiveLogCoordinator(navigationController: self.navigationController, log: log)
        self.archiveLogCoordinator?.start()
    }

}
