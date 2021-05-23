//
//  Logger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 08.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

/**
 Logger protocol
 */
public protocol Logger: AnyObject {

    var logLevel: LogLevel { get set }

    /**
     Log function to implement
     - parameter logEntry: The log entry
     */
    func doLog(_ logEntry: LogEntry)

}

public extension Logger {

    /**
     Log function to use.
     Only logs if log level is reached.
     - parameter logEntry: The log entry
     */
    func log(_ logEntry: LogEntry) {
        if logEntry.logLevel.rawValue <= self.logLevel.rawValue {
            self.doLog(logEntry)
        }
    }

}
