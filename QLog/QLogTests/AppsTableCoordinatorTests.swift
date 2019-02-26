//
//  AppsTableCoordinatorTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 27.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class AppsTableCoordinatorTests: XCTestCase {

    func testStart() {
        // 1. Arrange
        let navigationController = UINavigationController()
        let appsTableCoordinator = AppsTableCoordinator(navigationController: navigationController)

        // 2. Action
        appsTableCoordinator.start()

        // 3. Arrange
        XCTAssertTrue(navigationController.topViewController is AppsTableViewController)
    }

    // MARK: - AppsTableViewControllerDelegate

    func testBack() {
        // 1. Arrange
        let navigationController = UINavigationController()
        let appsTableCoordinator = AppsTableCoordinator(navigationController: navigationController)
        _ = UiLogger.getShared()
        UiLogger.shared?.shown = true
        appsTableCoordinator.start()

        // 2. Action
        appsTableCoordinator.back()

        // 3. Assert
        XCTAssertFalse(UiLogger.shared?.shown ?? true)
    }

    func testShow() {
        // 1. Arrange
        let navigationController = UINavigationController()
        let appsTableCoordinator = AppsTableCoordinator(navigationController: navigationController)
        _ = UiLogger.getShared()

        // 2. Action
        appsTableCoordinator.show(URL(string: "https://")!)

        // 3. Assert
        XCTAssertTrue(navigationController.topViewController is LogsTableViewController)
    }

}
