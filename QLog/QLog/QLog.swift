//
//  QLog.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import MobileCoreServices
import Zip

// MARK: - Static error functions

public func QLogHighlight<T>(file: String = #file, function: String = #function, line: Int = #line, _ object: T) {
    QLog.log(LogEntry(date: Date(), file: file, function: function, line: line, logLevel: .highlight, text: "\(object)"))
}

public func QLogDebug<T>(file: String = #file, function: String = #function, line: Int = #line, _ object: T) {
    QLog.log(LogEntry(date: Date(), file: file, function: function, line: line, logLevel: .debug, text: "\(object)"))
}

public func QLogInfo<T>(file: String = #file, function: String = #function, line: Int = #line, _ object: T) {
    QLog.log(LogEntry(date: Date(), file: file, function: function, line: line, logLevel: .info, text: "\(object)"))
}

public func QLogWarning<T>(file: String = #file, function: String = #function, line: Int = #line, _ object: T) {
    QLog.log(LogEntry(date: Date(), file: file, function: function, line: line, logLevel: .warning, text: "\(object)"))
}

public func QLogError<T>(file: String = #file, function: String = #function, line: Int = #line, _ object: T) {
    QLog.log(LogEntry(date: Date(), file: file, function: function, line: line, logLevel: .error, text: "\(object)"))
}

/**
 Global static class to hold all log settings
 */
public class QLog {

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()

    /// The name of the target (host app, share extension etc.)
    private static let targetName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Application"

    public struct Images {

        public static var archive = UIImage()
        public static var live = UIImage()
        public static var supportPackage = UIImage()

    }

    public struct Texts {

        public static var archive = "Archive"
        public static var live = "Live"
        public static var supportPackage = "Support Package"
        public static var generateSupportPackage = "Generate Support Package"

    }

    public static var loggers = [Logger]()
    public static var colorHighlight = UIColor.purple
    public static var colorDebug = UIColor.blue
    public static var colorInfo = UIColor.green
    public static var colorWarning = UIColor.orange
    public static var colorError = UIColor.red
    public static var colorText = UIColor.black
    public static var font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: UIFont.Weight.medium)

    public static func generateSupportPackage(viewController: UIViewController) {
        // Zip log files
        let zipDirectoryUrl = URL(fileURLWithPath: NSTemporaryDirectory())
        let zipFileUrl = zipDirectoryUrl.appendingPathComponent("Support Package \(QLog.targetName) \(QLog.dateFormatter.string(from: Date())).zip")
        let logPathUrl = UiLogger.shared.logUrl
        guard (try? Zip.zipFiles(paths: [logPathUrl], zipFilePath: zipFileUrl, password: nil, progress: { _ in })) != nil else {
            return
        }
        // Share zip file
        documentInteractionController = UIDocumentInteractionController()
        documentInteractionController.url = zipFileUrl
        documentInteractionController.uti = String(kUTTypeZipArchive)
        documentInteractionController.presentOptionsMenu(from: viewController.view.frame, in: viewController.view, animated: true)
    }

    /**
     Logs a log entry to all attached loggers
     - parameter logEntry: The log entry
     */
    static func log(_ logEntry: LogEntry) {
        for logger in QLog.loggers {
            logger.log(logEntry)
        }
    }

}
