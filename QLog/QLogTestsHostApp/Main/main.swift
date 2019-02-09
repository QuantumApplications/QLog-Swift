//
//  main.swift
//  QLogTestsHostApp
//
//  Created by Christian Oberdörfer on 04.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import UIKit

// Genius solution from http://qualitycoding.org/app-delegate-for-tests/
let appDelegateClass: AnyClass? = NSClassFromString("QLogTests.TestAppDelegate") ?? AppDelegate.self
_ = UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass!))
