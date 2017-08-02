//
//  LogViewController.swift
//  LogViewer
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 QuineSoft. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    var log: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let log = self.log {
            do {
                self.textView.text = try String(data: Data(contentsOf: log), encoding: .utf8)
            }
            catch {
            }
        }
    }

}
