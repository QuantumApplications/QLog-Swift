//
//  QLog.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

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

public class QLog {

    public struct Images {

        public static var archive = UIImage()
        public static var live = UIImage()
        public static var supportPackage = UIImage()

    }

    public struct Texts {

        public static var archive = "Archive"
        public static var live = "Live"
        public static var supportPackage = "Support Package"

    }

    public static var loggers = [Logger]()
    public static var colorHighlight = UIColor.purple
    public static var colorDebug = UIColor.blue
    public static var colorInfo = UIColor.green
    public static var colorWarning = UIColor.orange
    public static var colorError = UIColor.red
    public static var colorText = UIColor.black

    static func log(_ logEntry: LogEntry) {
        for logger in QLog.loggers {
            logger.log(logEntry)
        }
    }

}
