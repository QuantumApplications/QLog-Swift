//
//  RootViewCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 20.09.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import Foundation
import UIKit

protocol RootViewCoontrollerProvider: class {

    var rootViewController: UIViewController { get }

}

typealias  RootViewCoordinator = Coordinator & RootViewCoontrollerProvider
