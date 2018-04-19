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

    func testApps() {
        // 1. Arrange
        let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("logTest")
        let logDirectoryUrl = logUrl.appendingPathComponent("logDirectory")
        try? FileManager.default.createDirectory(at: logUrl, withIntermediateDirectories: true, attributes: nil)
        try? FileManager.default.createDirectory(at: logDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
        _ = UiLogger.getShared(logUrl: logUrl)

        // 3. Assert
        XCTAssertEqual(AppsTableViewController().apps.map { $0.absoluteString }, [logDirectoryUrl.absoluteString + "/"])

        // 4. Annihilate
        try? FileManager.default.removeItem(at: logDirectoryUrl)
        try? FileManager.default.removeItem(at: logUrl)
    }

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
        XCTAssertEqual(appsTableViewController.tabBarItem.title, QLog.Texts.archive)
        XCTAssertEqual(appsTableViewController.tabBarItem.image, QLog.Images.archive)
        XCTAssertEqual(appsTableViewController.tabBarItem.tag, 2)
    }

    func testInitWithCoder() {
        // 1. Arrange
        let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())

        // 2. Action
        let appsTableViewController = AppsTableViewController(coder: archiver)

        // 3. Assert
        XCTAssertNil(appsTableViewController)
    }

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
