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

    public var logLevel: LogLevel = .info

    static var shared: UiLogger?

    let logUrl: URL

    lazy var frameworkCoordinator: FrameworkCoordinator = FrameworkCoordinator()

    public static func getShared(logLevel: LogLevel = .info, logUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")) -> UiLogger {
        if UiLogger.shared == nil {
            UiLogger.shared = UiLogger(logLevel: logLevel, logUrl: logUrl)
        }
        return UiLogger.shared!
    }

    init(logLevel: LogLevel = .info, logUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")) {
        self.logLevel = logLevel
        self.logUrl = logUrl
        // Add QLog to CornerSwipeController
        CornerSwipeController.topRightCornerHandler = { self.frameworkCoordinator.start() }
        CornerSwipeController.enable()
    }

    public func doLog(_ logEntry: LogEntry) {
        DispatchQueue.main.async {
            self.frameworkCoordinator.logViewController.log(logEntry)
        }
    }

}
