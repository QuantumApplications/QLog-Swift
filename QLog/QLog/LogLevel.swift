//
//  LogLevel.swift
//  QLog
//
//  Created by Christian Oberdörfer on 08.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

public enum LogLevel: Int {

    case debug = 3
    case info = 2
    case warning = 1
    case error = 0

    var color: UIColor {
        switch self {
        case .debug:
            return QLog.debugColor
        case .info:
            return QLog.infoColor
        case .warning:
            return QLog.warningColor
        case .error:
            return QLog.errorColor
        }
    }

}
