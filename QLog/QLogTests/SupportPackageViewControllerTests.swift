//
//  SupportPackageViewControllerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 28.03.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class SupportPackageViewControllerTests: XCTestCase {

    func testInitWithCoder() {
        // 1. Arrange
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())

        // 2. Action
        let supportPackageViewController = SupportPackageViewController(coder: archiver)

        // 3. Assert
        XCTAssertNil(supportPackageViewController)
    }

}
