//
//  Logger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 08.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

public class Logger {

    let logLevel: LogLevel

    init(logLevel: LogLevel) {
        self.logLevel = logLevel
    }

    func log(_ logEntry: LogEntry) {
        if logEntry.logLevel.rawValue <= self.logLevel.rawValue {
            self.doLog(logEntry)
        }
    }

    func doLog(_ logEntry: LogEntry) {
    }

}
