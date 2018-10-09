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
        let liveLiveLogViewController = LiveLogViewController()

        // 3. Assert
        XCTAssertEqual(liveLiveLogViewController.navigationItem.leftBarButtonItem?.target as? LiveLogViewController, liveLiveLogViewController)
        XCTAssertEqual(liveLiveLogViewController.navigationItem.leftBarButtonItem?.action, #selector(LiveLogViewController.back))
        XCTAssertEqual(liveLiveLogViewController.navigationItem.rightBarButtonItem?.target as? LiveLogViewController, liveLiveLogViewController)
        XCTAssertEqual(liveLiveLogViewController.navigationItem.rightBarButtonItem?.action, #selector(LiveLogViewController.action))
        XCTAssertTrue(liveLiveLogViewController.extendedLayoutIncludesOpaqueBars)
        XCTAssertEqual(liveLiveLogViewController.tabBarItem.title, QLog.Texts.live)
        XCTAssertEqual(liveLiveLogViewController.tabBarItem.image, QLog.Images.live)
        XCTAssertEqual(liveLiveLogViewController.tabBarItem.tag, 1)
    }

    func testInitWithCoder() {
        // 1. Arrange
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())

        // 2. Action
        let liveLiveLogViewController = LiveLogViewController(coder: archiver)

        // 3. Assert
        XCTAssertNil(liveLiveLogViewController)
    }

    func testShowLog() {
        // 1. Arrange
        let liveLiveLogViewController = LiveLogViewController()
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log.test")
        FileManager.default.createFile(atPath: logUrl.path, contents: nil, attributes: nil)
        let logFileHandle = FileHandle(forWritingAtPath: logUrl.path)
        logFileHandle?.write("test".data(using: .utf8)!)

        // 2. Action
        liveLiveLogViewController.showLog(logUrl)

        // 3. Assert
        XCTAssertEqual(liveLiveLogViewController.textView.text, "test")

        // 4. Annihilate
        try? FileManager.default.removeItem(at: logUrl)
    }

    func testShowLogWrongLogUrl() {
        // 1. Arrange
        let liveLiveLogViewController = LiveLogViewController()
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log.test")

        // 2. Action
        liveLiveLogViewController.showLog(logUrl)

        // 3. Assert
        XCTAssertEqual(liveLiveLogViewController.textView.text, "")
    }

    func testBack() {
        // 1. Arrange
        let liveLiveLogViewControllerDelegate = MockLiveLogViewControllerDelegate()
        stub(liveLiveLogViewControllerDelegate) { liveLiveLogViewControllerDelegate in
            when(liveLiveLogViewControllerDelegate).back(any()).thenDoNothing()
        }
        let liveLiveLogViewController = LiveLogViewController()
        liveLiveLogViewController.delegate = liveLiveLogViewControllerDelegate

        // 2. Action
        liveLiveLogViewController.back()

        verify(liveLiveLogViewControllerDelegate).back(equal(to: liveLiveLogViewController))
        verifyNoMoreInteractions(liveLiveLogViewControllerDelegate)
    }

    func testAction() {
        // 1. Arrange
        let liveLiveLogViewControllerDelegate = MockLiveLogViewControllerDelegate()
        stub(liveLiveLogViewControllerDelegate) { liveLiveLogViewControllerDelegate in
            when(liveLiveLogViewControllerDelegate).action(any(), sender: any()).thenDoNothing()
        }
        let liveLiveLogViewController = LiveLogViewController()
        liveLiveLogViewController.delegate = liveLiveLogViewControllerDelegate
        let barButtonItem = UIBarButtonItem()

        // 2. Action
        liveLiveLogViewController.action(barButtonItem)

        // 3. Assert
        verify(liveLiveLogViewControllerDelegate).action(equal(to: liveLiveLogViewController), sender: equal(to: barButtonItem))
        verifyNoMoreInteractions(liveLiveLogViewControllerDelegate)
    }

}
