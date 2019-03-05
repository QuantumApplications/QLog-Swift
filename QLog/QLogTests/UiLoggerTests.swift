//
//  UiLoggerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 28.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
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

    func testGetShared() {
        // 3. Assert
        XCTAssertEqual(UiLogger.shared.with().logLevel, .info)
        XCTAssertEqual(UiLogger.shared.with().logUrl, FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log"))
        XCTAssertNotNil(CornerSwipeController.topRightCornerHandler)
    }

    func testGetSharedWithLogLevel() {
        // 3. Assert
        XCTAssertTrue(UiLogger.shared.with(logLevel: .error) === UiLogger.shared)
        XCTAssertEqual(UiLogger.shared.logLevel, .error)
        XCTAssertEqual(UiLogger.shared.logUrl, FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log"))
        XCTAssertNotNil(CornerSwipeController.topRightCornerHandler)
    }

    func testGetSharedWithLogUrl() {
        // 1. Arrange
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("test")

        // 3. Assert
        XCTAssertTrue(UiLogger.shared.with(logUrl: logUrl) === UiLogger.shared)
        XCTAssertEqual(UiLogger.shared.logLevel, .info)
        XCTAssertEqual(UiLogger.shared.logUrl, logUrl)
        XCTAssertNotNil(CornerSwipeController.topRightCornerHandler)
    }

    func testDoLog() {
        // 1. Arrange
        let expectation = self.expectation(description: "log")
        let liveLogCoordinator = MockLiveLogCoordinator(navigationController: UINavigationController())
        stub(liveLogCoordinator) { liveLogCoordinator in
            when(liveLogCoordinator).log(any()).then { _ in
                expectation.fulfill()
            }
        }
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
        let uiLogger = UiLogger.shared
        uiLogger.frameworkCoordinator.liveLogCoordinator = liveLogCoordinator

        // 2. Action
        uiLogger.doLog(logEntry)

        // 3. Assert
        waitForExpectations(timeout: 5, handler: nil)
        verify(liveLogCoordinator).log(equal(to: logEntry))
        verifyNoMoreInteractions(liveLogCoordinator)
    }

}
