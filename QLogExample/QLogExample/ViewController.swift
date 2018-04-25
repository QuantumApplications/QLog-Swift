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

    func log() {
        QLogHighlight("Highlight")
        QLogDebug("Debug")
        QLogInfo("Info")
        QLogWarning("Warning")
        QLogError("Error")
    }

    func run() {
        self.log()
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.run()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.run()
    }

}
