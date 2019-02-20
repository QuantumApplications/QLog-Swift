//
//  ArchiveLogCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 19.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation

class ArchiveLogCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let archiveLogViewController: ArchiveLogViewController
    private let log: URL

    init(navigationController: UINavigationController, log: URL) {
        self.navigationController = navigationController
        self.log = log
        self.archiveLogViewController = ArchiveLogViewController()
    }

    func start() {
        self.archiveLogViewController.webView.stopLoading()
        self.archiveLogViewController.webView.loadRequest(URLRequest(url: self.log))
        self.navigationController.show(self.archiveLogViewController, sender: nil)
    }

}
