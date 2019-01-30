//
//  FrameworkCoordinatorTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 08.04.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import XCTest

class FrameworkCoordinatorTests: XCTestCase {

    func testRootViewController() {
        // 3. Assert
        XCTAssertTrue(FrameworkCoordinator().rootViewController is UITabBarController)
    }

    func testStart() {
        // 1. Arrange
        let frameworkCoordinator = FrameworkCoordinator()

        // 2. Action
        frameworkCoordinator.start()

        // 3. Assert
        XCTAssertTrue(frameworkCoordinator.shown)
    }

    func testStartShown() {
        // 1. Arrange
        let frameworkCoordinator = FrameworkCoordinator()
        frameworkCoordinator.shown = true

        // 2. Action
        frameworkCoordinator.start()

        // 3. Assert
        XCTAssertTrue(frameworkCoordinator.shown)
    }

}
