//
//  QLog.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import MobileCoreServices
import UIKit

public struct LogEntry<T> {

    public enum LogLevel: String {

        case debug = "DEBUG"
        case info = "INFO"
        case warning = "WARNING"
        case error = "ERROR"

        var color: UIColor {
            switch self {
            case .debug:
                return QLog.debugColor
            case .info:
                return QLog.infoColor
            case .warning:
                return QLog.warningColor
            case .error:
                return QLog.errorColor
            }
        }

    }

    let object: T
    let file: String
    let function: String
    let line: Int
    let date: Date
    let logLevel: LogLevel

    public init(object: T, file: String, function: String, line: Int, date: Date, logLevel: LogLevel) {
        self.object = object
        self.file = file
        self.function = function
        self.line = line
        self.date = date
        self.logLevel = logLevel
    }

}

/// Needs to be global, otherwise the controller will be destroyed when the file is handed over to target application
var documentInteractionController: UIDocumentInteractionController!

// Needs to inherit from NSObject to allow selectors working properly
public class QLog: NSObject {

    static let font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: UIFont.Weight.medium)
    static let shared = QLog()

    public static var textColor = UIColor.red
    public static var debugColor = UIColor.blue
    public static var infoColor = UIColor.green
    public static var warningColor = UIColor.yellow
    public static var errorColor = UIColor.red
    public static var logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")

    let frameworkCoordinator: FrameworkCoordinator = FrameworkCoordinator()
    var logFileHandle: FileHandle?

    public static func enable() {
        // Add QLog to CornerSwipeController
        CornerSwipeController.topRightCornerHandler = { QLog.shared.frameworkCoordinator.start() }
        CornerSwipeController.enable()
        // Prepare log path
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let logDirectoryUrl = QLog.logUrl.appendingPathComponent(appName)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let logFileName = dateFormatter.string(from: Date()) + ".log"
        let logFileUrl = logDirectoryUrl.appendingPathComponent(logFileName)
        try? FileManager.default.createDirectory(at: logDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
        if FileManager.default.createFile(atPath: logFileUrl.path, contents: nil, attributes: nil) {
            if let logFileHandle = FileHandle(forWritingAtPath: logFileUrl.path) {
                QLog.shared.logFileHandle = logFileHandle
            }
        }
    }

    public static func log<T>(_ logEntry: LogEntry<T>) {
        let text = logEntry.object as? String ?? String(describing: logEntry.object)
        // Create log text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let metaText = "\(dateFormatter.string(from: logEntry.date)): \((logEntry.file as NSString).lastPathComponent):\(logEntry.line) \(logEntry.function): "
        // Log into view controller
        DispatchQueue.main.async {
            let viewController = QLog.shared.frameworkCoordinator.logViewController
            let attributedMetaText = NSMutableAttributedString(string: "\n\(metaText)", attributes: [NSAttributedStringKey.foregroundColor: QLog.textColor, NSAttributedStringKey.font: QLog.font])
            let attributedText = NSMutableAttributedString(string: "\(text)", attributes: [NSAttributedStringKey.foregroundColor: logEntry.logLevel.color, NSAttributedStringKey.font: QLog.font])
            let oldText = NSMutableAttributedString(attributedString: (viewController.textView.attributedText))
            oldText.append(attributedMetaText)
            oldText.append(attributedText)
            viewController.textView.attributedText = oldText
        }
        // Log into file
        QLog.shared.logFileHandle?.write("\n\(logEntry.logLevel): \(metaText)\(text)".data(using: .utf8)!)
    }

}

// Get top view controller
// Taken from https://stackoverflow.com/a/30858591/5804550

extension UIApplication {

    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

}
