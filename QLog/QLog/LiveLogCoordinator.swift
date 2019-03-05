//
//  LiveLogCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 26.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation
import MobileCoreServices

/// Coordinates handling of live logging
class LiveLogCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let liveLogViewController: LiveLogViewController

    /**
     Creates a new live log coordinator
     - parameter navigationController: The navigation controller to use
     */
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.liveLogViewController = LiveLogViewController()
        self.liveLogViewController.delegate = self
    }

    func start() {
        self.navigationController.navigationBar.topItem?.title = QLog.Texts.live
        self.liveLogViewController.tabBarItem = UITabBarItem(title: QLog.Texts.live, image: QLog.Images.live, tag: 1)
        self.navigationController.pushViewController(self.liveLogViewController, animated: true)
    }

    /**
     Logs a log entry
     - parameter logEntry: The log entry
     */
    func log(_ logEntry: LogEntry) {
        self.liveLogViewController.log(logEntry)
    }

}

// MARK: - LiveLogViewControllerDelegate

/// Needs to be global, otherwise the controller will be destroyed when the file is handed over to target application
var documentInteractionController: UIDocumentInteractionController!

extension LiveLogCoordinator: LiveLogViewControllerDelegate {

    /**
     Dismisses the view controller
     */
    func back() {
        UiLogger.shared.shown = false
        self.liveLogViewController.dismiss(animated: true, completion: nil)
    }

    /**
     Converts the logged text to HTML
     and presents the document interaction dialog to handle the file
     - parameter sender: The pressed UI bar button
     */
    func action(sender: UIBarButtonItem) {
        // Get attributed text
        guard let text = liveLogViewController.textView.attributedText else {
            return
        }
        // Convert attributed text to HTML
        let documentAttributes = [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html]
        let htmlData = (try? text.data(from: NSRange(location: 0, length: text.length), documentAttributes: documentAttributes)) ?? Data()
        // Save HTML to file
        let tempDirectory = NSTemporaryDirectory() as NSString
        let tempFilePath = tempDirectory.appendingPathComponent("log.htm")
        // Delete old file if existing
        if FileManager.default.fileExists(atPath: tempFilePath) {
            try? FileManager.default.removeItem(atPath: tempFilePath)
        }
        FileManager.default.createFile(atPath: tempFilePath, contents: htmlData, attributes: nil)
        // Share HTML file
        documentInteractionController = UIDocumentInteractionController()
        documentInteractionController.url = URL(fileURLWithPath: tempFilePath)
        documentInteractionController.uti = String(kUTTypeHTML)
        documentInteractionController.presentOptionsMenu(from: sender, animated: true)
    }

}
