//
//  TestAppDelegate.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 04.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import UIKit

var appWindow: UIWindow?

class TestAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        appWindow = self.window
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = UIViewController()
        self.window?.makeKeyAndVisible()
        return true
    }

}
