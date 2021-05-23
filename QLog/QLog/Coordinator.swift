//
//  Coordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 20.09.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import Foundation

/// The coordinator protocol
protocol Coordinator: AnyObject {

    /**
     Starts the coordinator and pushes the corresponding view controller
     */
    func start()

}
