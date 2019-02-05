//
//  AppDelegate.swift
//  QLogTestsHostApp
//
//  Created by Christian Oberdörfer on 04.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = UIViewController()
        self.window?.makeKeyAndVisible()
        return true
    }

}

