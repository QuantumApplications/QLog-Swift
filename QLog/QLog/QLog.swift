//
//  QLog.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

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

// Needs to inherit from NSObject to allow selectors working properly
public class QLog: NSObject {

    public static var textColor = UIColor.black
    public static var debugColor = UIColor.blue
    public static var infoColor = UIColor.green
    public static var warningColor = UIColor.yellow
    public static var errorColor = UIColor.red

    public static var loggers = [Logger]()

    static func log(_ logEntry: LogEntry) {
        for logger in QLog.loggers {
            logger.log(logEntry)
        }
    }

}
