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
        XCTAssertEqual(liveLogViewController.tabBarItem.title, QLog.Texts.live)
        XCTAssertEqual(liveLogViewController.tabBarItem.image, QLog.Images.live)
        XCTAssertEqual(liveLogViewController.tabBarItem.tag, 1)
    }

    func testInitWithCoder() {
        // 1. Arrange
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())

        // 2. Action
        let liveLogViewController = LiveLogViewController(coder: archiver)

        // 3. Assert
        XCTAssertNil(liveLogViewController)
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

    func testLogLevelSegmentedControlValueChanged() {
        // 1. Arrange
        let liveLogViewController = LiveLogViewController()
        let logLevel = LogLevel.error
        liveLogViewController.logLevelSegmentedControl.selectedSegmentIndex = logLevel.rawValue
        let object = NSObject()

        // 2. Action
        liveLogViewController.logLevelSegmentedControlValueChanged(object)

        // 3. Assert
        XCTAssertEqual(UiLogger.getShared().logLevel.rawValue, logLevel.rawValue)
    }

    func testBack() {
        // 1. Arrange
        let liveLogViewControllerDelegate = MockLiveLogViewControllerDelegate()
        stub(liveLogViewControllerDelegate) { liveLogViewControllerDelegate in
            when(liveLogViewControllerDelegate).back(any()).thenDoNothing()
        }
        let liveLogViewController = LiveLogViewController()
        liveLogViewController.delegate = liveLogViewControllerDelegate

        // 2. Action
        liveLogViewController.back()

        // 3. Assert
        verify(liveLogViewControllerDelegate).back(equal(to: liveLogViewController))
        verifyNoMoreInteractions(liveLogViewControllerDelegate)
    }

    func testAction() {
        // 1. Arrange
        let liveLogViewControllerDelegate = MockLiveLogViewControllerDelegate()
        stub(liveLogViewControllerDelegate) { liveLogViewControllerDelegate in
            when(liveLogViewControllerDelegate).action(any(), sender: any()).thenDoNothing()
        }
        let liveLogViewController = LiveLogViewController()
        liveLogViewController.delegate = liveLogViewControllerDelegate
        let barButtonItem = UIBarButtonItem()

        // 2. Action
        liveLogViewController.action(barButtonItem)

        // 3. Assert
        verify(liveLogViewControllerDelegate).action(equal(to: liveLogViewController), sender: equal(to: barButtonItem))
        verifyNoMoreInteractions(liveLogViewControllerDelegate)
    }

}
