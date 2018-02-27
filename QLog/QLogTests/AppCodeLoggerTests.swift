//
//  AppCodeLoggerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 27.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import XCTest

class AppCodeLoggerTests: XCTestCase {

    func testAnsiColor() {
        // 3. Assert
        XCTAssertEqual(LogLevel.highlight.ansiColor, "35m")
        XCTAssertEqual(LogLevel.debug.ansiColor, "34m")
        XCTAssertEqual(LogLevel.info.ansiColor, "32m")
        XCTAssertEqual(LogLevel.warning.ansiColor, "33m")
        XCTAssertEqual(LogLevel.error.ansiColor, "31m")
    }

    func testInit() {
        // 3. Assert
        XCTAssertEqual(AppCodeLogger().logLevel, .highlight)
    }

    func testInitWithData() {
        // 1. Arrange
        let appCodeLogger = AppCodeLogger(logLevel: .error)

        // 3. Assert
        XCTAssertEqual(appCodeLogger.logLevel, .error)
    }

    func testDoLog() {
        // 1. Arrange
        let dateString = "04:07:11"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: dateString)!
        let path = "Directory/File.dat"
        let function = "Function"
        let line = 0
        let logLevel: LogLevel = .error
        let text = "Text"
        let logEntry = LogEntry(date: date, file: path, function: function, line: line, logLevel: logLevel, text: text)
        let appCodeLogger = AppCodeLogger()

        // 2. Action
        appCodeLogger.doLog(logEntry)
    }

}
