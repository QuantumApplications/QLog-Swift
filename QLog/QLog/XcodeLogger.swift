//
//  XcodeLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 08.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

extension LogLevel {

    var emoji: String {
        switch self {
        case .debug:
            return "💙"
        case .info:
            return "💚"
        case .warning:
            return "💛"
        case .error:
            return "❤️"
        }
    }

}

class XcodeLogger: Logger {

    override func doLog(_ logEntry: LogEntry) {
        print("\(logEntry.metaText)\(logEntry.logLevel.emoji)\(logEntry.text)\(logEntry.logLevel.emoji)")
    }

}
