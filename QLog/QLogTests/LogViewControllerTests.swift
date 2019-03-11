//
//  LiveLogViewControllerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 22.03.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class LiveLogViewControllerMock: LiveLogViewController {
    var scrolled = false
    override func scroll() {
        self.scrolled = true
    }
}

class LiveLogViewControllerTests: XCTestCase {

    func testInit() {
        // 2. Action
        let liveLogViewController = LiveLogViewController()

        // 3. Assert
        XCTAssertEqual(liveLogViewController.navigationItem.leftBarButtonItem?.target as? LiveLogViewController, liveLogViewController)
        XCTAssertEqual(liveLogViewController.navigationItem.leftBarButtonItem?.action, #selector(LiveLogViewController.back))
        XCTAssertEqual(liveLogViewController.navigationItem.rightBarButtonItem?.target as? LiveLogViewController, liveLogViewController)
        XCTAssertEqual(liveLogViewController.navigationItem.rightBarButtonItem?.action, #selector(LiveLogViewController.action))
        XCTAssertTrue(liveLogViewController.extendedLayoutIncludesOpaqueBars)
    }

    func testInitWithCoder() {
        // 1. Arrange
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())

        // 2. Action
        let liveLogViewController = LiveLogViewController(coder: archiver)

        // 3. Assert
        XCTAssertNil(liveLogViewController)
    }

    func testLog() {
        // 1. Arrange
        let logEntry = LogEntry(date: Date(), file: "", function: "", line: 0, logLevel: .error, text: "Text")
        let attributedMetaText = NSMutableAttributedString(string: "\n\(logEntry.metaText)", attributes: [NSAttributedString.Key.foregroundColor: QLog.colorText, NSAttributedString.Key.font: QLog.font])
        let attributedText = NSMutableAttributedString(string: "\(logEntry.text)", attributes: [NSAttributedString.Key.foregroundColor: logEntry.logLevel.color, NSAttributedString.Key.font: QLog.font])
        let attributedTesttext = attributedMetaText
        attributedTesttext.append(attributedText)
        let liveLogViewController = LiveLogViewControllerMock()

        // 2. Action
        liveLogViewController.log(logEntry)

        // 3. Assert
        XCTAssertEqual(liveLogViewController.textView.attributedText, attributedTesttext)
        XCTAssertTrue(liveLogViewController.scrolled)
    }

    func testLogTwice() {
        // 1. Arrange
        let logEntry = LogEntry(date: Date(), file: "", function: "", line: 0, logLevel: .error, text: "Text")
        let logEntry2 = LogEntry(date: Date(), file: "", function: "", line: 0, logLevel: .error, text: "Text 2")
        let attributedMetaText = NSMutableAttributedString(string: "\n\(logEntry.metaText)", attributes: [NSAttributedString.Key.foregroundColor: QLog.colorText, NSAttributedString.Key.font: QLog.font])
        let attributedMetaText2 = NSMutableAttributedString(string: "\n\(logEntry2.metaText)", attributes: [NSAttributedString.Key.foregroundColor: QLog.colorText, NSAttributedString.Key.font: QLog.font])
        let attributedText = NSMutableAttributedString(string: "\(logEntry.text)", attributes: [NSAttributedString.Key.foregroundColor: logEntry.logLevel.color, NSAttributedString.Key.font: QLog.font])
        let attributedText2 = NSMutableAttributedString(string: "\(logEntry2.text)", attributes: [NSAttributedString.Key.foregroundColor: logEntry.logLevel.color, NSAttributedString.Key.font: QLog.font])
        let attributedTestText = attributedMetaText
        attributedTestText.append(attributedText)
        attributedTestText.append(attributedMetaText2)
        attributedTestText.append(attributedText2)
        let liveLogViewController = LiveLogViewControllerMock()

        // 2. Action
        liveLogViewController.log(logEntry)
        liveLogViewController.log(logEntry2)

        // 3. Assert
        XCTAssertEqual(liveLogViewController.textView.attributedText, attributedTestText)
        XCTAssertTrue(liveLogViewController.scrolled)
    }

    func testShowLog() {
        // 1. Arrange
        let liveLogViewController = LiveLogViewController()
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log.test")
        FileManager.default.createFile(atPath: logUrl.path, contents: nil, attributes: nil)
        let logFileHandle = FileHandle(forWritingAtPath: logUrl.path)
        logFileHandle?.write("test".data(using: .utf8)!)

        // 2. Action
        liveLogViewController.showLog(logUrl)

        // 3. Assert
        XCTAssertEqual(liveLogViewController.textView.text, "test")

        // 4. Annihilate
        try? FileManager.default.removeItem(at: logUrl)
    }

    func testShowLogWrongLogUrl() {
        // 1. Arrange
        let liveLogViewController = LiveLogViewController()
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log.test")

        // 2. Action
        liveLogViewController.showLog(logUrl)

        // 3. Assert
        XCTAssertEqual(liveLogViewController.textView.text, "")
    }

    func testScroll() {
        // 1. Arrange
        let liveLogViewController = LiveLogViewController()
        liveLogViewController.textView.bounds = CGRect(x: 0, y: 0, width: 0, height: 100)
        liveLogViewController.view.bounds = CGRect(x: 0, y: 0, width: 0, height: 50)

        // 2. Action
        liveLogViewController.scroll()

        // 3. Assert
        liveLogViewController.scrollView.contentOffset = CGPoint(x: 0, y: 50)
    }

    func testScrollNoChange() {
        // 1. Arrange
        let liveLogViewController = LiveLogViewController()

        // 2. Action
        liveLogViewController.scroll()

        // 3. Assert
        liveLogViewController.scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }

    // MARK: - Navigation

    func testLogLevelSegmentedControlValueChanged() {
        // 1. Arrange
        let liveLogViewController = LiveLogViewController()
        let logLevel = LogLevel.error
        liveLogViewController.logLevelSegmentedControl.selectedSegmentIndex = logLevel.rawValue
        let object = NSObject()

        // 2. Action
        liveLogViewController.logLevelSegmentedControlValueChanged(object)

        // 3. Assert
        XCTAssertEqual(UiLogger.shared.logLevel.rawValue, logLevel.rawValue)
    }

    func testLogLevelSegmentedControlValueChangedInvalidIndex() {
        // 1. Arrange
        let liveLogViewController = LiveLogViewController()
        let logLevel = LogLevel.warning
        UiLogger.shared.logLevel = logLevel
        let logLevelSegmentedControl = UISegmentedControl(items: ["0", "1", "2", "3", "4", "5", "6"])
        logLevelSegmentedControl.selectedSegmentIndex = 7
        liveLogViewController.logLevelSegmentedControl = logLevelSegmentedControl
        let object = NSObject()

        // 2. Action
        liveLogViewController.logLevelSegmentedControlValueChanged(object)

        // 3. Assert
        XCTAssertEqual(UiLogger.shared.logLevel.rawValue, logLevel.rawValue)
    }

    func testBack() {
        // 1. Arrange
        let liveLogViewControllerDelegate = MockLiveLogViewControllerDelegate()
        stub(liveLogViewControllerDelegate) { liveLogViewControllerDelegate in
            when(liveLogViewControllerDelegate).back().thenDoNothing()
        }
        let liveLogViewController = LiveLogViewController()
        liveLogViewController.delegate = liveLogViewControllerDelegate

        // 2. Action
        liveLogViewController.back()

        // 3. Assert
        verify(liveLogViewControllerDelegate).back()
        verifyNoMoreInteractions(liveLogViewControllerDelegate)
    }

    func testAction() {
        // 1. Arrange
        let liveLogViewControllerDelegate = MockLiveLogViewControllerDelegate()
        stub(liveLogViewControllerDelegate) { liveLogViewControllerDelegate in
            when(liveLogViewControllerDelegate).action(sender: any()).thenDoNothing()
        }
        let liveLogViewController = LiveLogViewController()
        liveLogViewController.delegate = liveLogViewControllerDelegate
        let barButtonItem = UIBarButtonItem()

        // 2. Action
        liveLogViewController.action(barButtonItem)

        // 3. Assert
        verify(liveLogViewControllerDelegate).action(sender: equal(to: barButtonItem))
        verifyNoMoreInteractions(liveLogViewControllerDelegate)
    }

}
