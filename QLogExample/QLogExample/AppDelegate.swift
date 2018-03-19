//
//  AppDelegate.swift
//  QLogExample
//
//  Created by Christian Oberdörfer on 23.01.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

import QLog
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // QLog settings
        QLog.Texts.archive = "Archive".localized
        QLog.Texts.live = "Live".localized
        QLog.Texts.supportPackage = "Support Package".localized
        QLog.loggers = [AppCodeLogger(), XcodeLogger(), FileLogger(), UiLogger.getShared()]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
        return true
    }

}
