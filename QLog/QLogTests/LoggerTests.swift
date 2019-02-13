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

    func testEquals() {
        // 1. Arrange
        let date = Date()
        let logEntry1 = LogEntry(date: date, file: "", function: "", line: 0, logLevel: .error, text: "")
        let logEntry2 = LogEntry(date: date, file: "", function: "", line: 0, logLevel: .error, text: "")

        // 3. Assert
        XCTAssertTrue(logEntry1 == logEntry2)
        XCTAssertEqual(logEntry1, logEntry2)
    }

    func testEqualsDifferentDate() {
        // 1. Arrange
        let logEntry1 = LogEntry(date: Date(), file: "", function: "", line: 0, logLevel: .error, text: "")
        let logEntry2 = LogEntry(date: Date(), file: "", function: "", line: 0, logLevel: .error, text: "")

        // 3. Assert
        XCTAssertFalse(logEntry1 == logEntry2)
        XCTAssertNotEqual(logEntry1, logEntry2)
    }

    func testEqualsDifferentFile() {
        // 1. Arrange
        let date = Date()
        let logEntry1 = LogEntry(date: date, file: "1", function: "", line: 0, logLevel: .error, text: "")
        let logEntry2 = LogEntry(date: date, file: "2", function: "", line: 0, logLevel: .error, text: "")

        // 3. Assert
        XCTAssertFalse(logEntry1 == logEntry2)
        XCTAssertNotEqual(logEntry1, logEntry2)
    }

    func testEqualsDifferentFunction() {
        // 1. Arrange
        let date = Date()
        let logEntry1 = LogEntry(date: date, file: "", function: "1", line: 0, logLevel: .error, text: "")
        let logEntry2 = LogEntry(date: date, file: "", function: "2", line: 0, logLevel: .error, text: "")

        // 3. Assert
        XCTAssertFalse(logEntry1 == logEntry2)
        XCTAssertNotEqual(logEntry1, logEntry2)
    }

    func testEqualsDifferentLine() {
        // 1. Arrange
        let date = Date()
        let logEntry1 = LogEntry(date: date, file: "", function: "", line: 1, logLevel: .error, text: "")
        let logEntry2 = LogEntry(date: date, file: "", function: "", line: 2, logLevel: .error, text: "")

        // 3. Assert
        XCTAssertFalse(logEntry1 == logEntry2)
        XCTAssertNotEqual(logEntry1, logEntry2)
    }

    func testEqualsDifferentLogLevel() {
        // 1. Arrange
        let date = Date()
        let logEntry1 = LogEntry(date: date, file: "", function: "", line: 0, logLevel: .warning, text: "")
        let logEntry2 = LogEntry(date: date, file: "", function: "", line: 0, logLevel: .error, text: "")

        // 3. Assert
        XCTAssertFalse(logEntry1 == logEntry2)
        XCTAssertNotEqual(logEntry1, logEntry2)
    }

    func testEqualsDifferentText() {
        // 1. Arrange
        let date = Date()
        let logEntry1 = LogEntry(date: date, file: "", function: "", line: 0, logLevel: .error, text: "1")
        let logEntry2 = LogEntry(date: date, file: "", function: "", line: 0, logLevel: .error, text: "2")

        // 3. Assert
        XCTAssertFalse(logEntry1 == logEntry2)
        XCTAssertNotEqual(logEntry1, logEntry2)
    }

}
