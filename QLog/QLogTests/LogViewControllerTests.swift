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

        // 3. Assert
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
