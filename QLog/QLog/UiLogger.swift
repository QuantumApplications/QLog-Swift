//
//  UiLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 09.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

extension LogLevel {

    /// Associates a UI color with each log level
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
/**
 Logger to allow live logging.
 Also shows archive and support package views.
 Logger is shown via swipe gesture of corner swipe controller.
 */
public class UiLogger: Logger {

    /// The shared UI logger
    public static var shared: UiLogger {
        return UiLogger.sharedUiLogger
    }

    /// The log level
    public var logLevel: LogLevel = .info

    lazy var frameworkCoordinator: FrameworkCoordinator = FrameworkCoordinator()

    var logUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")

    /// True if logger is shown via framework coordinator
    var shown = false

    /// The internal shared UI logger
    private static var sharedUiLogger: UiLogger = {
        return UiLogger()
    }()

    /**
     Changes log level and log url of the shared UI logger and returns it
     - parameter logLevel: The new log level. Default is info.
     - parameter logUrl: The new log URL. Default is "log" in documents directory.
     - returns: The shared UI logger
     */
    public func with(logLevel: LogLevel = .info, logUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")) -> UiLogger {
        UiLogger.sharedUiLogger.logLevel = logLevel
        UiLogger.sharedUiLogger.logUrl = logUrl
        return UiLogger.sharedUiLogger
    }

    public func doLog(_ logEntry: LogEntry) {
        DispatchQueue.main.async {
            self.frameworkCoordinator.liveLogCoordinator.log(logEntry)
        }
    }

    /**
     Creates a new UI logger
     and add the framework coordinator to the corner swipe controller
     */
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
