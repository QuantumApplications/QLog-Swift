//
//  LogViewControllerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 22.03.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class LogViewControllerTests: XCTestCase {

    func testInit() {
        // 2. Action
        let logViewController = LogViewController()

        // 3. Assert
        XCTAssertNil(logViewController.navigationItem.leftBarButtonItem)
        XCTAssertEqual(logViewController.navigationItem.rightBarButtonItem?.target as? LogViewController, logViewController)
        XCTAssertEqual(logViewController.navigationItem.rightBarButtonItem?.action, #selector(LogViewController.action))
        XCTAssertTrue(logViewController.extendedLayoutIncludesOpaqueBars)
        XCTAssertEqual(logViewController.tabBarItem.title, QLog.Texts.live)
        XCTAssertEqual(logViewController.tabBarItem.image, QLog.Images.live)
        XCTAssertEqual(logViewController.tabBarItem.tag, 1)
    }

    func testInitWithCancelButton() {
        // 2. Action
        let logViewController = LogViewController(cancelButton: true)

        // 3. Assert
        XCTAssertEqual(logViewController.navigationItem.leftBarButtonItem?.target as? LogViewController, logViewController)
        XCTAssertEqual(logViewController.navigationItem.leftBarButtonItem?.action, #selector(LogViewController.back))
        XCTAssertEqual(logViewController.navigationItem.rightBarButtonItem?.target as? LogViewController, logViewController)
        XCTAssertEqual(logViewController.navigationItem.rightBarButtonItem?.action, #selector(LogViewController.action))
        XCTAssertTrue(logViewController.extendedLayoutIncludesOpaqueBars)
        XCTAssertEqual(logViewController.tabBarItem.title, QLog.Texts.live)
        XCTAssertEqual(logViewController.tabBarItem.image, QLog.Images.live)
        XCTAssertEqual(logViewController.tabBarItem.tag, 1)
    }


    func testInitWithCoder() {
        // 1. Arrange
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())

        // 2. Action
        let logViewController = LogViewController(coder: archiver)

        // 3. Assert
        XCTAssertNil(logViewController)
    }

    func testShowLog() {
        // 1. Arrange
        let logViewController = LogViewController()
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log.test")
        FileManager.default.createFile(atPath: logUrl.path, contents: nil, attributes: nil)
        let logFileHandle = FileHandle(forWritingAtPath: logUrl.path)
        logFileHandle?.write("test".data(using: .utf8)!)

        // 2. Action
        logViewController.showLog(logUrl)

        // 3. Assert
        XCTAssertEqual(logViewController.textView.text, "test")

        // 4. Annihilate
        try? FileManager.default.removeItem(at: logUrl)
    }

    func testShowLogWrongLogUrl() {
        // 1. Arrange
        let logViewController = LogViewController()
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log.test")

        // 2. Action
        logViewController.showLog(logUrl)

        // 3. Assert
        XCTAssertEqual(logViewController.textView.text, "")
    }

    func testBack() {
        // 1. Arrange
        let logViewControllerDelegate = MockLogViewControllerDelegate()
        stub(logViewControllerDelegate) { logViewControllerDelegate in
            when(logViewControllerDelegate).back(any()).thenDoNothing()
        }
        let logViewController = LogViewController()
        logViewController.delegate = logViewControllerDelegate

        // 2. Action
        logViewController.back()

        verify(logViewControllerDelegate).back(equal(to: logViewController))
        verifyNoMoreInteractions(logViewControllerDelegate)
    }

    func testAction() {
        // 1. Arrange
        let logViewControllerDelegate = MockLogViewControllerDelegate()
        stub(logViewControllerDelegate) { logViewControllerDelegate in
            when(logViewControllerDelegate).action(any(), sender: any()).thenDoNothing()
        }
        let logViewController = LogViewController()
        logViewController.delegate = logViewControllerDelegate
        let barButtonItem = UIBarButtonItem()

        // 2. Action
        logViewController.action(barButtonItem)

        // 3. Assert
        verify(logViewControllerDelegate).action(equal(to: logViewController), sender: equal(to: barButtonItem))
        verifyNoMoreInteractions(logViewControllerDelegate)
    }

}
