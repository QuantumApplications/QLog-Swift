//
//  ArchiveLogViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 29.04.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

import UIKit

class ArchiveLogViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    init() {
        super.init(nibName: "ArchiveLogViewController", bundle: Bundle(identifier: "qa.quantum.QLog")!)
        self.loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

}
