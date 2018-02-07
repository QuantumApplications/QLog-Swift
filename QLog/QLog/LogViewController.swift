//
//  LogViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import UIKit

protocol LogViewControllerDelegate: class {

    func back(_ logViewController: LogViewController)
    func action(_ logViewController: LogViewController, sender: UIBarButtonItem)

}

class LogViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textView: UITextView!

    weak var delegate: LogViewControllerDelegate?

    init(cancelButton: Bool = false) {
        super.init(nibName: "LogViewController", bundle: Bundle(identifier: "qa.quantum.QLog")!)
        self.loadView()
        // Add bar buttons
        if cancelButton {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(action))
        // Allow scrolling if navigation bars are opaque (WTF Apple?)
        self.extendedLayoutIncludesOpaqueBars = true
        self.tabBarItem = UITabBarItem(title: "Live", image: UIImage(), tag: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func showLog(_ logUrl: URL) {
        self.textView.text = String(data: (try? Data(contentsOf: logUrl)) ?? Data(), encoding: .utf8)
    }

    // MARK: - Navigation

    @objc func back() {
        self.delegate?.back(self)
    }

    @objc func action(_ sender: UIBarButtonItem) {
        self.delegate?.action(self, sender: sender)
    }

}
