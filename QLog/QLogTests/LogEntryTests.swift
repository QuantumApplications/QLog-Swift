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

}
