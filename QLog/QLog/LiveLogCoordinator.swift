//
//  LiveLogCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 26.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation
import MobileCoreServices

class LiveLogCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let liveLogViewController: LiveLogViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.liveLogViewController = LiveLogViewController()
        liveLogViewController.delegate = self
    }

    func start() {
        self.navigationController.navigationBar.topItem?.title = QLog.Texts.live
        self.liveLogViewController.tabBarItem = UITabBarItem(title: QLog.Texts.live, image: QLog.Images.live, tag: 1)
        self.navigationController.pushViewController(self.liveLogViewController, animated: true)
    }

    func log(_ logEntry: LogEntry) {
        self.liveLogViewController.log(logEntry)
    }

}

// MARK: - LiveLogViewControllerDelegate

/// Needs to be global, otherwise the controller will be destroyed when the file is handed over to target application
var documentInteractionController: UIDocumentInteractionController!

extension LiveLogCoordinator: LiveLogViewControllerDelegate {

    func back(_ liveLogViewController: LiveLogViewController) {
        UiLogger.shared?.shown = false
        liveLogViewController.dismiss(animated: true, completion: nil)
    }

    func action(_ liveLogViewController: LiveLogViewController, sender: UIBarButtonItem) {
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
