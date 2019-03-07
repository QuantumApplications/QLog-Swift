//
//  AppCodeLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 09.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

extension LogLevel {

    /// Associates an ansi color with each log level
    var ansiColor: String {
        switch self {
        case .highlight:
            return "35m"
        case .debug:
            return "34m"
        case .info:
            return "32m"
        case .warning:
            return "33m"
        case .error:
            return "31m"
        }
    }

    var ansiColorSequence: String {
        return "\(LogLevel.escape)[\(self.ansiColor)"
    }

    private static let escape  = "\u{001b}"

}

/**
 Logger to log into AppCode console.
 */
public class AppCodeLogger: Logger {

    public var logLevel: LogLevel = .highlight

    private static let ansiTextColor = "37m"
    private static let escape  = "\u{001b}"
    private static let ansiBold  = "1m"
    private static let ansiReset = "0m"
    private static let ansiBoldSequence = "\(escape)[\(ansiBold)"
    private static let ansiResetSequence = "\(escape)[\(ansiReset)"
    private static let ansiTextSequence = "\(escape)[\(ansiTextColor)"

    public init(logLevel: LogLevel = .highlight) {
        self.logLevel = logLevel
    }

    public func doLog(_ logEntry: LogEntry) {
        print("\(AppCodeLogger.ansiBoldSequence)\(AppCodeLogger.ansiTextSequence)\(logEntry.metaText)\(AppCodeLogger.ansiBoldSequence)\(logEntry.logLevel.ansiColorSequence)\(logEntry.text)\(AppCodeLogger.ansiResetSequence)")
    }

}
