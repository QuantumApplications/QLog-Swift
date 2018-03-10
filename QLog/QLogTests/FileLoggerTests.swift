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

    func testInit() {
        // 3. Assert
        XCTAssertEqual(FileLogger().logLevel, .info)
        XCTAssertNotNil(FileLogger().logFileHandle)
        XCTAssertEqual(FileLogger().logUrl, FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log"))
    }

    func testInitWithLogLevel() {
        // 1. Arrange
        let fileLogger = FileLogger(logLevel: .error)

        // 3. Assert
        XCTAssertEqual(fileLogger.logLevel, .error)
        XCTAssertNotNil(fileLogger.logFileHandle)
        XCTAssertEqual(fileLogger.logUrl, FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log"))
    }

    func testInitWithLogUrl() {
        // 1. Arrange
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("test")

        // 2. Action
        let fileLogger = FileLogger(logUrl: logUrl)

        // 3. Assert
        XCTAssertEqual(fileLogger.logLevel, .info)
        XCTAssertNotNil(fileLogger.logFileHandle)
        XCTAssertEqual(fileLogger.logUrl, logUrl)
    }

    func testInitWithWrongLogUrl() {
        // 1. Arrange
        let logUrl = URL(string: "file://")!

        // 2. Action
        let fileLogger = FileLogger(logUrl: logUrl)

        // 3. Assert
        XCTAssertEqual(fileLogger.logLevel, .info)
        XCTAssertNil(fileLogger.logFileHandle)
        XCTAssertEqual(fileLogger.logUrl, logUrl)
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
