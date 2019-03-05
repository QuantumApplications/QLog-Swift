//
//  LogsTableCoordinatorTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 28.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class LogsTableCoordinatorTests: XCTestCase {

    func testStart() {
        // 1. Arrange
        let navigationController = UINavigationController()
        let logsTableCoordinator = LogsTableCoordinator(navigationController: navigationController, app: URL(string: "https://")!)

        // 2. Action
        logsTableCoordinator.start()

        // 3. Arrange
        XCTAssertTrue(navigationController.topViewController is LogsTableViewController)
    }

    // MARK: - LogsTableViewControllerDelegate

    func testDidSelect() {
        // 1. Arrange
        let navigationController = UINavigationController()
        let logsTableCoordinator = LogsTableCoordinator(navigationController: navigationController, app: URL(string: "https://")!)
        UiLogger.shared.shown = true
        logsTableCoordinator.start()

        // 2. Action
        logsTableCoordinator.didSelect(URL(string: "https://")!)
    }

}
