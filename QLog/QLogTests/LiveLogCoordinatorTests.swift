//
//  LiveLogCoordinatorTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 02.03.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class LiveLogCoordinatorTests: XCTestCase {

    func testStart() {
        // 1. Arrange
        let navigationController = UINavigationController()
        let liveLogCoordinator = LiveLogCoordinator(navigationController: navigationController)

        // 2. Action
        liveLogCoordinator.start()

        // 3. Arrange
        XCTAssertTrue(navigationController.topViewController is LiveLogViewController)
    }

    // MARK: - LiveLogViewControllerDelegate

    func testBack() {
        // 1. Arrange
        let navigationController = UINavigationController()
        let liveLogCoordinator = LiveLogCoordinator(navigationController: navigationController)
        _ = UiLogger.getShared()
        UiLogger.shared?.shown = true
        liveLogCoordinator.start()

        // 2. Action
        liveLogCoordinator.back()

        // 3. Assert
        XCTAssertFalse(UiLogger.shared?.shown ?? true)
    }

}
