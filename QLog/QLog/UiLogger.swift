//
//  UiLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 09.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

extension LogLevel {

    var color: UIColor {
        switch self {
        case .highlight:
            return UIColor.purple
        case .debug:
            return UIColor.blue
        case .info:
            return UIColor.green
        case .warning:
            return UIColor.orange
        case .error:
            return UIColor.red
        }
    }

}

/// Needs to be global, otherwise the controller will be destroyed when the file is handed over to target application
var documentInteractionController: UIDocumentInteractionController!

public class UiLogger: Logger {

    static var shared: UiLogger?

    let font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: UIFont.Weight.medium)
    let frameworkCoordinator: FrameworkCoordinator = FrameworkCoordinator()
    let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")
    let textColor = UIColor.black

    override init(logLevel: LogLevel = .warning) {
        super.init(logLevel: logLevel)
        // Add QLog to CornerSwipeController
        CornerSwipeController.topRightCornerHandler = { self.frameworkCoordinator.start() }
        CornerSwipeController.enable()
    }

    override func doLog(_ logEntry: LogEntry) {
        DispatchQueue.main.async {
            let viewController = self.frameworkCoordinator.logViewController
            let attributedMetaText = NSMutableAttributedString(string: "\n\(logEntry.metaText)", attributes: [NSAttributedStringKey.foregroundColor: self.textColor, NSAttributedStringKey.font: self.font])
            let attributedText = NSMutableAttributedString(string: "\(logEntry.text)", attributes: [NSAttributedStringKey.foregroundColor: logEntry.logLevel.color, NSAttributedStringKey.font: self.font])
            let oldText = NSMutableAttributedString(attributedString: (viewController.textView.attributedText))
            oldText.append(attributedMetaText)
            oldText.append(attributedText)
            viewController.textView.attributedText = oldText
        }
    }

    public static func getShared(logLevel: LogLevel = .warning) -> UiLogger {
        if UiLogger.shared == nil {
            UiLogger.shared = UiLogger(logLevel: logLevel)
        }
        return UiLogger.shared!
    }

}
