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

    func showLog() {
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
