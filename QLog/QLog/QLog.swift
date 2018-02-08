//
//  QLog.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import MobileCoreServices
import UIKit

public func QLogDebug<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line, _ date: Date = Date()) {
    QLog.log(LogEntry(date: date, file: file, function: function, line: line, logLevel: LogLevel.debug, text: "\(object)"))
}

public func QLogInfo<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line, _ date: Date = Date()) {
    QLog.log(LogEntry(date: date, file: file, function: function, line: line, logLevel: LogLevel.info, text: "\(object)"))
}

public func QLogWarning<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line, _ date: Date = Date()) {
    QLog.log(LogEntry(date: date, file: file, function: function, line: line, logLevel: LogLevel.warning, text: "\(object)"))
}

public func QLogError<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line, _ date: Date = Date()) {
    QLog.log(LogEntry(date: date, file: file, function: function, line: line, logLevel: LogLevel.error, text: "\(object)"))
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

    public static func log(_ logEntry: LogEntry) {
        // Log into view controller
        DispatchQueue.main.async {
            let viewController = QLog.shared.frameworkCoordinator.logViewController
            let attributedMetaText = NSMutableAttributedString(string: "\n\(logEntry.metaText)", attributes: [NSAttributedStringKey.foregroundColor: QLog.textColor, NSAttributedStringKey.font: QLog.font])
            let attributedText = NSMutableAttributedString(string: "\(logEntry.text)", attributes: [NSAttributedStringKey.foregroundColor: logEntry.logLevel.color, NSAttributedStringKey.font: QLog.font])
            let oldText = NSMutableAttributedString(attributedString: (viewController.textView.attributedText))
            oldText.append(attributedMetaText)
            oldText.append(attributedText)
            viewController.textView.attributedText = oldText
        }
        // Log into file
        QLog.shared.logFileHandle?.write("\n\(logEntry.logLevel): \(logEntry.metaText)\(logEntry.text)".data(using: .utf8)!)
    }

}
