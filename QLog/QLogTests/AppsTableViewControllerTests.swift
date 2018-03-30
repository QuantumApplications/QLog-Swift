//
//  AppsTableViewControllerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 30.03.18.
//  Copyright © 2018 Quantum. All rights reserved.
//
@testable import QLog
import Cuckoo
import XCTest

class AppsTableViewControllerTests: XCTestCase {

    func testBack() {
        // 1. Arrange
        let appsTableViewControllerDelegate = MockAppsTableViewControllerDelegate()
        stub(appsTableViewControllerDelegate) { appsTableViewControllerDelegate in
            when(appsTableViewControllerDelegate).back(any()).thenDoNothing()
        }
        let appsTableViewController = AppsTableViewController()
        appsTableViewController.delegate = appsTableViewControllerDelegate

        // 2. Action
        appsTableViewController.back()

        verify(appsTableViewControllerDelegate).back(equal(to: appsTableViewController))
        verifyNoMoreInteractions(appsTableViewControllerDelegate)
    }

}
