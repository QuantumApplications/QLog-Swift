//
//  LogEntryTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

@testable import QLog
import XCTest

class LogEntryTests: XCTestCase {

    func testMetaText() {
        // 1. Arrange
        let dateString = "04:07:11"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: dateString)!
        let file = "File.dat"
        let path = "Directory/File.dat"
        let function = "Function"
        let line = 0
        let logLevel: LogLevel = .error
        let text = "Text"
        let logEntry = LogEntry(date: date, file: path, function: function, line: line, logLevel: logLevel, text: text)

        // 3. Assert
        XCTAssertEqual(logEntry.metaText, "\(dateString): \(file):\(line) \(function): ")
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
        let logEntry1 = LogEntry(date: Date(timeIntervalSince1970: 1), file: "", function: "", line: 0, logLevel: .error, text: "")
        let logEntry2 = LogEntry(date: Date(timeIntervalSince1970: 2), file: "", function: "", line: 0, logLevel: .error, text: "")

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
