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
        // 1. Arrange
        UiLogger.shared = nil

        // 3. Assert
        XCTAssertTrue(UiLogger.getShared() === UiLogger.shared!)
        XCTAssertTrue(UiLogger.getShared() === UiLogger.shared!)
        XCTAssertEqual(UiLogger.getShared().logLevel, .info)
        XCTAssertEqual(UiLogger.getShared().logUrl, FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log"))
        XCTAssertNotNil(CornerSwipeController.topRightCornerHandler)
    }

    func testGetSharedWithLogLevel() {
        // 1. Arrange
        UiLogger.shared = nil

        // 3. Assert
        XCTAssertTrue(UiLogger.getShared(logLevel: .error) === UiLogger.shared!)
        XCTAssertEqual(UiLogger.getShared().logLevel, .error)
        XCTAssertEqual(UiLogger.getShared().logUrl, FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log"))
        XCTAssertNotNil(CornerSwipeController.topRightCornerHandler)
    }

    func testGetSharedWithLogUrl() {
        // 1. Arrange
        UiLogger.shared = nil
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("test")

        // 3. Assert
        XCTAssertTrue(UiLogger.getShared(logUrl: logUrl) === UiLogger.shared!)
        XCTAssertEqual(UiLogger.getShared().logLevel, .info)
        XCTAssertEqual(UiLogger.getShared().logUrl, logUrl)
        XCTAssertNotNil(CornerSwipeController.topRightCornerHandler)
    }

    func testInit() {
        // 2. Action
        let uiLogger = UiLogger()
        CornerSwipeController.topRightCornerHandler?()

        // 3. Assert
        XCTAssertEqual(uiLogger.logLevel, .info)
        XCTAssertEqual(uiLogger.logUrl, FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log"))
        XCTAssertNotNil(CornerSwipeController.topRightCornerHandler)
        XCTAssertTrue(uiLogger.frameworkCoordinator.shown)
    }

    func testInitWithLogLevel() {
        // 1. Arrange
        let uiLogger = UiLogger(logLevel: .error)

        // 3. Assert
        XCTAssertEqual(uiLogger.logLevel, .error)
        XCTAssertEqual(uiLogger.logUrl, FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log"))
        XCTAssertNotNil(CornerSwipeController.topRightCornerHandler)
    }

    func testInitWithLogUrl() {
        // 1. Arrange
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("test")

        // 2. Action
        let uiLogger = UiLogger(logUrl: logUrl)

        // 3. Assert
        XCTAssertEqual(uiLogger.logLevel, .info)
        XCTAssertEqual(uiLogger.logUrl, logUrl)
        XCTAssertNotNil(CornerSwipeController.topRightCornerHandler)
    }

    func testInitWithWrongLogUrl() {
        // 1. Arrange
        let logUrl = URL(string: "file://")!

        // 2. Action
        let uiLogger = UiLogger(logUrl: logUrl)

        // 3. Assert
        XCTAssertEqual(uiLogger.logLevel, .info)
        XCTAssertEqual(uiLogger.logUrl, logUrl)
        XCTAssertNotNil(CornerSwipeController.topRightCornerHandler)
    }

    func testDoLog() {
        // 1. Arrange
        class LiveLogViewControllerMock: LiveLogViewController {
            var expectation: XCTestExpectation?
            var logged = false
            override func log(_ logEntry: LogEntry) {
                self.logged = true
                self.expectation?.fulfill()
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
        let uiLogger = UiLogger()
        let liveLogViewController = LiveLogViewControllerMock()
        uiLogger.frameworkCoordinator.liveLogViewController = liveLogViewController
        let expectation = self.expectation(description: "log")
        liveLogViewController.expectation = expectation

        // 2. Action
        uiLogger.doLog(logEntry)

        // 3. Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(liveLogViewController.logged)
    }

}
