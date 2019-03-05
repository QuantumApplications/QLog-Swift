//
//  UiLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 09.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

extension LogLevel {

    var color: UIColor {
        switch self {
        case .highlight:
            return QLog.colorHighlight
        case .debug:
            return QLog.colorDebug
        case .info:
            return QLog.colorInfo
        case .warning:
            return QLog.colorWarning
        case .error:
            return QLog.colorError
        }
    }

}

public class UiLogger: Logger {

    public static var shared: UiLogger {
        return UiLogger.sharedUiLogger
    }

    public var logLevel: LogLevel = .info

    lazy var frameworkCoordinator: FrameworkCoordinator = FrameworkCoordinator()

    var logUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")

    var shown = false

    private static var sharedUiLogger: UiLogger = {
        return UiLogger()
    }()

    public func with (logLevel: LogLevel = .info, logUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")) -> UiLogger {
        UiLogger.sharedUiLogger.logLevel = logLevel
        UiLogger.sharedUiLogger.logUrl = logUrl
        return UiLogger.sharedUiLogger
    }

    public func doLog(_ logEntry: LogEntry) {
        DispatchQueue.main.async {
            self.frameworkCoordinator.liveLogCoordinator.log(logEntry)
        }
    }

    private init() {
        // Add QLog to CornerSwipeController
        CornerSwipeController.topRightCornerHandler = {
            guard !self.shown else {
                return
            }
            self.shown = true
            self.frameworkCoordinator.start()
        }
        CornerSwipeController.enable()
    }

}
