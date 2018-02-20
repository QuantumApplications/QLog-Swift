//
//  LoggerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 20.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import XCTest

class LoggerTests: XCTestCase {

    class TestLogger: Logger {

        var logged = false

        public var logLevel: LogLevel = .highlight

        public func doLog(_ logEntry: LogEntry) {
            self.logged = true
        }

    }

    func testLogLowerLogLevel() {
        // 1. Arrange
        let logEntry = LogEntry(date: Date(), file: "", function: "", line: 0, logLevel: .error, text: "")
        let logger = TestLogger()
        logger.logLevel = .warning

        // 2. Action
        logger.log(logEntry)

        // 3. Assert
        XCTAssertTrue(logger.logged)
    }

    func testLogSameLogLevel() {
        // 1. Arrange
        let logEntry = LogEntry(date: Date(), file: "", function: "", line: 0, logLevel: .warning, text: "")
        let logger = TestLogger()
        logger.logLevel = .warning

        // 2. Action
        logger.log(logEntry)

        // 3. Assert
        XCTAssertTrue(logger.logged)
    }

    func testLogHigherLogLevel() {
        // 1. Arrange
        let logEntry = LogEntry(date: Date(), file: "", function: "", line: 0, logLevel: .info, text: "")
        let logger = TestLogger()
        logger.logLevel = .warning

        // 2. Action
        logger.log(logEntry)

        // 3. Assert
        XCTAssertFalse(logger.logged)
    }

}
