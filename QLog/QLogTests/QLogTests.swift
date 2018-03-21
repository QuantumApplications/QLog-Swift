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
    var loggedLevel: LogLevel = .highlight

    func doLog(_ logEntry: LogEntry) {
        self.logged = true
        self.loggedLevel = logEntry.logLevel
    }

}

class QLogTests: XCTestCase {

    func testQLogHighlight() {
        // 1. Arrange
        let testLogger = TestLogger()
        QLog.loggers = [testLogger]

        // 2. Action
        QLogHighlight("test")

        // 3. Assert
        XCTAssertTrue(testLogger.logged)
        XCTAssertEqual(testLogger.loggedLevel, LogLevel.highlight)
    }

    func testQLogDebug() {
        // 1. Arrange
        let testLogger = TestLogger()
        QLog.loggers = [testLogger]

        // 2. Action
        QLogDebug("test")

        // 3. Assert
        XCTAssertTrue(testLogger.logged)
        XCTAssertEqual(testLogger.loggedLevel, LogLevel.debug)
    }

    func testQLogInfo() {
        // 1. Arrange
        let testLogger = TestLogger()
        QLog.loggers = [testLogger]

        // 2. Action
        QLogInfo("test")

        // 3. Assert
        XCTAssertTrue(testLogger.logged)
        XCTAssertEqual(testLogger.loggedLevel, LogLevel.info)
    }

    func testQLogWarning() {
        // 1. Arrange
        let testLogger = TestLogger()
        QLog.loggers = [testLogger]

        // 2. Action
        QLogWarning("test")

        // 3. Assert
        XCTAssertTrue(testLogger.logged)
        XCTAssertEqual(testLogger.loggedLevel, LogLevel.warning)
    }

    func testQLogError() {
        // 1. Arrange
        let testLogger = TestLogger()
        QLog.loggers = [testLogger]

        // 2. Action
        QLogError("test")

        // 3. Assert
        XCTAssertTrue(testLogger.logged)
        XCTAssertEqual(testLogger.loggedLevel, LogLevel.error)
    }

}
