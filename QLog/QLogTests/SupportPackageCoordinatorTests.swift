//
//  SupportPackageCoordinatorTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 03.03.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class SupportPackageCoordinatorTests: XCTestCase {

    func testStart() {
        // 1. Arrange
        let navigationController = UINavigationController()
        let supportPackageCoordinator = SupportPackageCoordinator(navigationController: navigationController)

        // 2. Action
        supportPackageCoordinator.start()

        // 3. Arrange
        XCTAssertTrue(navigationController.topViewController is SupportPackageViewController)
    }

    // MARK: - SupportPackageViewControllerDelegate

    func testBack() {
        // 1. Arrange
        let navigationController = UINavigationController()
        let supportPackageCoordinator = SupportPackageCoordinator(navigationController: navigationController)
        _ = UiLogger.shared
        UiLogger.shared.shown = true
        supportPackageCoordinator.start()

        // 2. Action
        supportPackageCoordinator.back()

        // 3. Assert
        XCTAssertFalse(UiLogger.shared.shown)
    }

}
