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

    func testAppsEmptyLogUrl() {
        // 1. Arrange
        UiLogger.shared = nil

        // 3. Assert
        XCTAssertEqual(AppsTableViewController().apps, [URL]())
    }

    func testAppsWrongLogUrl() {
        // 1. Arrange
        _ = UiLogger.getShared(logUrl: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("xxx"))

        // 3. Assert
        XCTAssertEqual(AppsTableViewController().apps, [URL]())
    }

    func testInitWithCancelButton() {
        // 2. Action
        let appsTableViewController = AppsTableViewController()

        // 3. Assert
        XCTAssertEqual(appsTableViewController.navigationItem.leftBarButtonItem?.target as? AppsTableViewController, appsTableViewController)
        XCTAssertEqual(appsTableViewController.navigationItem.leftBarButtonItem?.action, #selector(AppsTableViewController.back))
        XCTAssertNil(appsTableViewController.navigationItem.rightBarButtonItem)
    }

    func testInitWithCoder() {
        // 1. Arrange
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())

        // 2. Action
        let appsTableViewController = AppsTableViewController(coder: archiver)

        // 3. Assert
        XCTAssertNil(appsTableViewController)
    }

    // MARK: - Table view data source

    func testNumberOfSections() {
        // 1. Arrange
        let appsTableViewController = AppsTableViewController()

        // 3. Assert
        XCTAssertEqual(appsTableViewController.numberOfSections(in: appsTableViewController.tableView), 1)
    }

    func testNumberOfRowsInSection() {
        // 1. Arrange
        let appsTableViewController = AppsTableViewController()

        // 3. Assert
        XCTAssertEqual(appsTableViewController.tableView(appsTableViewController.tableView, numberOfRowsInSection: 0), 0)
    }

    func testHeightForRowAt() {
        // 1. Arrange
        let appsTableViewController = AppsTableViewController()

        // 3. Assert
        XCTAssertEqual(appsTableViewController.tableView(appsTableViewController.tableView, heightForRowAt: IndexPath(row: 0, section: 0)), 44.0)
    }

    func testCellForRowAt() {
        // 1. Arrange
        let app = URL(string: "https://test")!
        let appsTableViewController = MockAppsTableViewController().withEnabledSuperclassSpy()
        stub(appsTableViewController) { appsTableViewController in
            when(appsTableViewController.apps.get).thenReturn([app])
        }

        // 2. Action
        let cell = appsTableViewController.tableView(appsTableViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        // 3. Assert
        XCTAssertTrue(cell is TableViewCell)
        XCTAssertEqual((cell as! TableViewCell).nameLabel.text, app.lastPathComponent)
        XCTAssertEqual((cell as! TableViewCell).separatorInset, UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15))
        XCTAssertEqual((cell as! TableViewCell).layoutMargins, UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 15))
    }

    func testDidSelectRowAt() {
        // 1. Arrange
        let app = URL(string: "https://")!
        let appsTableViewControllerDelegate = MockAppsTableViewControllerDelegate()
        stub(appsTableViewControllerDelegate) { appsTableViewControllerDelegate in
            when(appsTableViewControllerDelegate).show(any()).thenDoNothing()
        }
        let appsTableViewController = MockAppsTableViewController().withEnabledSuperclassSpy()
        stub(appsTableViewController) { appsTableViewController in
            when(appsTableViewController.apps.get).thenReturn([app])
        }
        appsTableViewController.delegate = appsTableViewControllerDelegate

        // 2. Action
        appsTableViewController.tableView(appsTableViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        // 3. Assert
        verify(appsTableViewControllerDelegate).show(equal(to: app))
        verifyNoMoreInteractions(appsTableViewControllerDelegate)
    }

    // MARK: - Navigation

    func testBack() {
        // 1. Arrange
        let appsTableViewControllerDelegate = MockAppsTableViewControllerDelegate()
        stub(appsTableViewControllerDelegate) { appsTableViewControllerDelegate in
            when(appsTableViewControllerDelegate).back().thenDoNothing()
        }
        let appsTableViewController = AppsTableViewController()
        appsTableViewController.delegate = appsTableViewControllerDelegate

        // 2. Action
        appsTableViewController.back()

        // 3. Assert
        verify(appsTableViewControllerDelegate).back()
        verifyNoMoreInteractions(appsTableViewControllerDelegate)
    }

}
