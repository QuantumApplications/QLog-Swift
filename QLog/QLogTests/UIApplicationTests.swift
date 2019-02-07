//
//  UIApplicationTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 10.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import XCTest

class UIApplicationTests: XCTestCase {

    func testTopViewController() {
        // 1. Arrange
        let viewController = UIViewController()
        appWindow?.rootViewController = viewController

        // 3. Assert
        XCTAssertEqual(UIApplication.topViewController(), viewController)
    }

    func testTopViewControllerNavigationController() {
        // 1. Arrange
        let viewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        appWindow?.rootViewController = navigationController

        // 3. Assert
        XCTAssertEqual(UIApplication.topViewController(), viewController)
    }

    func testTopViewControllerTabBarController() {
        // 1. Arrange
        let viewController = UIViewController()
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [viewController]
        appWindow?.rootViewController = tabBarController

        // 3. Assert
        XCTAssertEqual(UIApplication.topViewController(), viewController)
    }

}
