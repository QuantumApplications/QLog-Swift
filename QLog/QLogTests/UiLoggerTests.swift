//
//  UiLoggerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 28.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import XCTest

class UiLoggerTests: XCTestCase {

    func testText() {
        // 3. Assert
        XCTAssertEqual(LogLevel.highlight.color, QLog.colorHighlight)
        XCTAssertEqual(LogLevel.debug.color, QLog.colorDebug)
        XCTAssertEqual(LogLevel.info.color, QLog.colorInfo)
        XCTAssertEqual(LogLevel.warning.color, QLog.colorWarning)
        XCTAssertEqual(LogLevel.error.color, QLog.colorError)
    }

    func testInit() {
        // 3. Assert
        XCTAssertEqual(UiLogger().logLevel, .info)
    }

    func testInitWithData() {
        // 1. Arrange
        let uiLogger = UiLogger(logLevel: .error)

        // 3. Assert
        XCTAssertEqual(uiLogger.logLevel, .error)
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
        let uiLogger = UiLogger()

        // 2. Action
        uiLogger.doLog(logEntry)
    }

}
