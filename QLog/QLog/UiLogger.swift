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
            return QLog.colorHighlight
        case .debug:
            return QLog.colorDebug
        case .info:
            return QLog.colorInfo
        case .warning:
            return QLog.colorWarning
        case .error:
            return QLog.colorError
        }
    }

}

/// Needs to be global, otherwise the controller will be destroyed when the file is handed over to target application
var documentInteractionController: UIDocumentInteractionController!

public class UiLogger: Logger {

    static var shared: UiLogger?

    public var logLevel: LogLevel = .info

    let font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: UIFont.Weight.medium)
    let frameworkCoordinator: FrameworkCoordinator = FrameworkCoordinator()
    let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")

    public static func getShared(logLevel: LogLevel = .info) -> UiLogger {
        if UiLogger.shared == nil {
            UiLogger.shared = UiLogger(logLevel: logLevel)
        }
        return UiLogger.shared!
    }

    public init(logLevel: LogLevel = .info) {
        self.logLevel = logLevel        // Add QLog to CornerSwipeController
        CornerSwipeController.topRightCornerHandler = { self.frameworkCoordinator.start() }
        CornerSwipeController.enable()
    }

    public func doLog(_ logEntry: LogEntry) {
        DispatchQueue.main.async {
            let viewController = self.frameworkCoordinator.logViewController
            let attributedMetaText = NSMutableAttributedString(string: "\n\(logEntry.metaText)", attributes: [NSAttributedStringKey.foregroundColor: QLog.colorText, NSAttributedStringKey.font: self.font])
            let attributedText = NSMutableAttributedString(string: "\(logEntry.text)", attributes: [NSAttributedStringKey.foregroundColor: logEntry.logLevel.color, NSAttributedStringKey.font: self.font])
            let oldText = NSMutableAttributedString(attributedString: (viewController.textView.attributedText))
            oldText.append(attributedMetaText)
            oldText.append(attributedText)
            viewController.textView.attributedText = oldText
        }
    }

}
