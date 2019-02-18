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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.archiveLogViewController = ArchiveLogViewController()
        //archiveLogViewController.delegate = self
    }

    func start() {
        self.navigationController.pushViewController(self.archiveLogViewController, animated: true)
    }

}
