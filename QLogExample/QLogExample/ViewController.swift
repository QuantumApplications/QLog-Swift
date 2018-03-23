//
//  ViewController.swift
//  QLogExample
//
//  Created by Christian Oberdörfer on 23.01.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

import QLog
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        for _ in 1..<10 {
            QLogHighlight("Highlight")
            QLogDebug("Debug")
            QLogInfo("Info")
            QLogWarning("Warning")
            QLogError("Error")
        }
        super.viewDidLoad()
    }

}