//
//  XcodeLoggerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 21.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import XCTest

class XcodeLoggerTests: XCTestCase {

    func testEmoji() {
        // 3. Assert
        XCTAssertEqual(LogLevel.highlight.emoji, "🔮")
        XCTAssertEqual(LogLevel.debug.emoji, "🌀")
        XCTAssertEqual(LogLevel.info.emoji, "📗")
        XCTAssertEqual(LogLevel.warning.emoji, "⚠️")
        XCTAssertEqual(LogLevel.error.emoji, "⛔️")
    }

    func testInit() {
        // 3. Assert
        XCTAssertEqual(XcodeLogger().logLevel, .highlight)
    }

    func testInitWithData() {
        // 1. Arrange
        let xcodeLogger = XcodeLogger(logLevel: .error)

        // 3. Assert
        XCTAssertEqual(xcodeLogger.logLevel, .error)
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
        let xcodeLogger = XcodeLogger()

        // 2. Action
        xcodeLogger.doLog(logEntry)
    }

}
