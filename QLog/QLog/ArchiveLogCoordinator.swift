//
//  ArchiveLogCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 19.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation

/// Coordinates handling of archived logs
class ArchiveLogCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let archiveLogViewController: ArchiveLogViewController
    private let log: URL

    /**
     Creates a new archive log coordinator
     - parameter navigationController: The navigation controller to use
     */
    init(navigationController: UINavigationController, log: URL) {
        self.navigationController = navigationController
        self.archiveLogViewController = ArchiveLogViewController()
        self.log = log
    }

    func start() {
        self.archiveLogViewController.webView.stopLoading()
        self.archiveLogViewController.webView.loadRequest(URLRequest(url: self.log))
        self.navigationController.show(self.archiveLogViewController, sender: nil)
    }

}
