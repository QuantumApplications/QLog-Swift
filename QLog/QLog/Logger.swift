//
//  Logger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 08.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

public protocol Logger: class {

    var logLevel: LogLevel { get set }

    func log(_ logEntry: LogEntry)

    func doLog(_ logEntry: LogEntry)

}

public extension Logger {

    func log(_ logEntry: LogEntry) {
        if logEntry.logLevel.rawValue <= self.logLevel.rawValue {
            self.doLog(logEntry)
        }
    }

}
