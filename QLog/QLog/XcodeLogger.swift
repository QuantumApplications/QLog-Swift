//
//  XcodeLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 08.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

extension LogLevel {

    /// Associates a emoji with each log level
    var emoji: String {
        switch self {
        case .highlight:
            return "🔮"
        case .debug:
            return "🌀"
        case .info:
            return "📗"
        case .warning:
            return "⚠️"
        case .error:
            return "⛔️"
        }
    }

}

/**
 Logger to log into Xcode console.
 Since Xcode console does not support coloring
 each log message is wrapped into a corresponding pair of emojis.
 */
public class XcodeLogger: Logger {

    public var logLevel: LogLevel = .highlight

    public init(logLevel: LogLevel = .highlight) {
        self.logLevel = logLevel
    }

    public func doLog(_ logEntry: LogEntry) {
        print("\(logEntry.logLevel.emoji) \(logEntry.metaText)\(logEntry.text)")
    }

}
