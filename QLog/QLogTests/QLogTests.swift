//
//  QLogTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 11.03.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class TestLogger: Logger {

    public var logLevel: LogLevel = .highlight

    var logged = false

    func doLog(_ logEntry: LogEntry) {
        self.logged = true
    }

}

class QLogTests: XCTestCase {

    func testGetCalls() {
        // 1. Arrange
        let testLogger = TestLogger()
        QLog.loggers = [testLogger]

        // 2. Action
        QLogHighlight("test")

        // 3. Assert
        XCTAssertTrue(testLogger.logged)
    }

}
