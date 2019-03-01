//
//  ArchiveLogCoordinatorTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 01.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class ArchiveLogCoordinatorTests: XCTestCase {

    func testStart() {
        // 1. Arrange
        let navigationController = UINavigationController()
        let archiveLogCoordinator = ArchiveLogCoordinator(navigationController: navigationController, log: URL(string: "https://")!)

        // 2. Action
        archiveLogCoordinator.start()

        // 3. Arrange
        XCTAssertTrue(navigationController.topViewController is ArchiveLogViewController)
    }

}
