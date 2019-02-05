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
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
UIApplicationMain(CommandLine.argc, args, nil, NSStringFromClass(appDelegateClass!))
