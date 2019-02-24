//
//  ArchiveLogViewControllerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 10.05.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import XCTest

class ArchiveLogViewControllerTests: XCTestCase {

    func testInit() {
        // 2. Action
        let archiveLogViewController = ArchiveLogViewController()

        // 3. Assert
        XCTAssertNotNil(archiveLogViewController)
    }

    func testInitWithCoder() {
        // 1. Arrange
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())

        // 2. Action
        let archiveLogViewController = ArchiveLogViewController(coder: archiver)

        // 3. Assert
        XCTAssertNil(archiveLogViewController)
    }

}
