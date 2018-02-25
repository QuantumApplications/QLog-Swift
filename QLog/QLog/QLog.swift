//
//  QLog.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

public func QLogHighlight<T>(date: Date = Date(), file: String = #file, function: String = #function, line: Int = #line, _ object: T) {
    QLog.log(LogEntry(date: date, file: file, function: function, line: line, logLevel: LogLevel.highlight, text: "\(object)"))
}

public func QLogDebug<T>(date: Date = Date(), file: String = #file, function: String = #function, line: Int = #line, _ object: T) {
    QLog.log(LogEntry(date: date, file: file, function: function, line: line, logLevel: LogLevel.debug, text: "\(object)"))
}

public func QLogInfo<T>(date: Date = Date(), file: String = #file, function: String = #function, line: Int = #line, _ object: T) {
    QLog.log(LogEntry(date: date, file: file, function: function, line: line, logLevel: LogLevel.info, text: "\(object)"))
}

public func QLogWarning<T>(date: Date = Date(), file: String = #file, function: String = #function, line: Int = #line, _ object: T) {
    QLog.log(LogEntry(date: date, file: file, function: function, line: line, logLevel: LogLevel.warning, text: "\(object)"))
}

public func QLogError<T>(date: Date = Date(), file: String = #file, function: String = #function, line: Int = #line, _ object: T) {
    QLog.log(LogEntry(date: date, file: file, function: function, line: line, logLevel: LogLevel.error, text: "\(object)"))
}

public class QLog {

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
