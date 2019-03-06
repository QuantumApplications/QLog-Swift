//
//  FileLoggerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 28.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import XCTest

class FileLoggerTests: XCTestCase {

    func testText() {
        // 3. Assert
        XCTAssertEqual(LogLevel.highlight.text, "[HIGH] ")
        XCTAssertEqual(LogLevel.debug.text, "[DEBUG]")
        XCTAssertEqual(LogLevel.info.text, "[INFO] ")
        XCTAssertEqual(LogLevel.warning.text, "[WARN] ")
        XCTAssertEqual(LogLevel.error.text, "[ERROR]")
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
        let fileLogger = FileLogger()

        // 2. Action
        fileLogger.doLog(logEntry)
    }

}
