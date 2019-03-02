//
//  LiveLogViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import UIKit

protocol LiveLogViewControllerDelegate: class {

    func back()
    func action(sender: UIBarButtonItem)

}

class LiveLogViewController: UIViewController {

    static let font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: UIFont.Weight.medium)

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logLevelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var logLevelSegmentedControlHeight: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!

    weak var delegate: LiveLogViewControllerDelegate?

    init() {
        super.init(nibName: "LiveLogViewController", bundle: Bundle(identifier: "qa.quantum.QLog")!)
        self.loadView()
        // Add bar buttons
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(action))
        // Allow scrolling if navigation bars are opaque (WTF Apple?)
        self.extendedLayoutIncludesOpaqueBars = true
        // Set segmented control
        self.logLevelSegmentedControl.selectedSegmentIndex = UiLogger.getShared().logLevel.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    func log(_ logEntry: LogEntry) {
        let attributedMetaText = NSMutableAttributedString(string: "\n\(logEntry.metaText)", attributes: [NSAttributedString.Key.foregroundColor: QLog.colorText, NSAttributedString.Key.font: LiveLogViewController.font])
        let attributedText = NSMutableAttributedString(string: "\(logEntry.text)", attributes: [NSAttributedString.Key.foregroundColor: logEntry.logLevel.color, NSAttributedString.Key.font: LiveLogViewController.font])
        let oldText = NSMutableAttributedString(attributedString: (self.textView.attributedText))
        oldText.append(attributedMetaText)
        oldText.append(attributedText)
        self.textView.attributedText = oldText
        self.scroll()
    }

    func showLog(_ logUrl: URL) {
        self.logLevelSegmentedControl.isHidden = true
        self.logLevelSegmentedControlHeight.constant = 0
        self.textView.text = String(data: (try? Data(contentsOf: logUrl)) ?? Data(), encoding: .utf8)
    }

    func scroll() {
        if self.textView.bounds.size.height > self.view.bounds.size.height {
            let bottom = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
            self.scrollView.setContentOffset(bottom, animated: true)
        }
    }

    // MARK: - Navigation

    @IBAction func logLevelSegmentedControlValueChanged(_ sender: Any) {
        UiLogger.getShared().logLevel = LogLevel(rawValue: self.logLevelSegmentedControl.selectedSegmentIndex) ?? UiLogger.getShared().logLevel
    }

    @objc func back() {
        self.delegate?.back()
    }

    @objc func action(_ sender: UIBarButtonItem) {
        self.delegate?.action(sender: sender)
    }

}
