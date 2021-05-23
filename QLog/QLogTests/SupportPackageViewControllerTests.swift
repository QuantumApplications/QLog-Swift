//
//  SupportPackageViewControllerTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 28.03.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

@testable import QLog
import Cuckoo
import XCTest

class SupportPackageViewControllerTests: XCTestCase {

    func testInitWithCoder() {
        // 1. Arrange
        let archiver = NSKeyedArchiver(requiringSecureCoding: false)

        // 2. Action
        let supportPackageViewController = SupportPackageViewController(coder: archiver)

        // 3. Assert
        XCTAssertNil(supportPackageViewController)
    }

    func testBack() {
        // 1. Arrange
        let supportPackageViewControllerDelegate = MockSupportPackageViewControllerDelegate()
        stub(supportPackageViewControllerDelegate) { supportPackageViewControllerDelegate in
            when(supportPackageViewControllerDelegate).back().thenDoNothing()
        }
        let supportPackageViewController = SupportPackageViewController()
        supportPackageViewController.delegate = supportPackageViewControllerDelegate

        // 2. Action
        supportPackageViewController.back()

        verify(supportPackageViewControllerDelegate).back()
        verifyNoMoreInteractions(supportPackageViewControllerDelegate)
    }

    func testGenerateSupportPackage() {
        // 1. Arrange
        let supportPackageViewControllerDelegate = MockSupportPackageViewControllerDelegate()
        stub(supportPackageViewControllerDelegate) { supportPackageViewControllerDelegate in
            when(supportPackageViewControllerDelegate).generateSupportPackage().thenDoNothing()
        }
        let supportPackageViewController = SupportPackageViewController()
        supportPackageViewController.delegate = supportPackageViewControllerDelegate
        let barButtonItem = UIBarButtonItem()

        // 2. Action
        supportPackageViewController.generateSupportPackage(barButtonItem)

        // 3. Assert
        verify(supportPackageViewControllerDelegate).generateSupportPackage()
        verifyNoMoreInteractions(supportPackageViewControllerDelegate)
    }

}
