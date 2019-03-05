//
//  FrameworkCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 20.09.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import Foundation
import UIKit

/// Coordinates handling of the framework
class FrameworkCoordinator: RootViewCoordinator {

    let appsTableCoordinator: AppsTableCoordinator
    var liveLogCoordinator: LiveLogCoordinator
    let supportPackageCoordinator: SupportPackageCoordinator

    var rootViewController: UIViewController {
        return self.tabbarController
    }

    private lazy var tabbarController: UITabBarController = {
        let tabBarController = UITabBarController()
        return tabBarController
    }()

    init() {
        let liveLogNavigationController = UINavigationController()
        self.liveLogCoordinator = LiveLogCoordinator(navigationController: liveLogNavigationController)
        liveLogCoordinator.start()

        let appsTableNavigationController = UINavigationController()
        self.appsTableCoordinator = AppsTableCoordinator(navigationController: appsTableNavigationController)
        appsTableCoordinator.start()

        let supportPackageNavigationController = UINavigationController()
        self.supportPackageCoordinator = SupportPackageCoordinator(navigationController: supportPackageNavigationController)
        supportPackageCoordinator.start()

        self.tabbarController.viewControllers = [liveLogNavigationController, appsTableNavigationController, supportPackageNavigationController]
    }

    func start() {
        UIApplication.topViewController()?.present(self.rootViewController, animated: true, completion: nil)
    }

}
