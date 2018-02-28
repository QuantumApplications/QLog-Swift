//
//  FileLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 09.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

extension LogLevel {

    var text: String {
        switch self {
        case .highlight:
            return "[HIGH] "
        case .debug:
            return "[DEBUG]"
        case .info:
            return "[INFO] "
        case .warning:
            return "[WARN] "
        case .error:
            return "[ERROR]"
        }
    }

}

public class FileLogger: Logger {

    public var logLevel: LogLevel = .info

    var logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")

    var logFileHandle: FileHandle?

    public init(logLevel: LogLevel = .info, logUrl: URL? = nil) {
        self.logLevel = logLevel
        if let logUrl = logUrl {
            self.logUrl = logUrl
        }
        // Prepare log path
        guard let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String else {
            return
        }
        let logDirectoryUrl = self.logUrl.appendingPathComponent(appName)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let logFileName = dateFormatter.string(from: Date()) + ".log"
        let logFileUrl = logDirectoryUrl.appendingPathComponent(logFileName)
        try? FileManager.default.createDirectory(at: logDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
        guard FileManager.default.createFile(atPath: logFileUrl.path, contents: nil, attributes: nil) else {
            return
        }
        guard let logFileHandle = FileHandle(forWritingAtPath: logFileUrl.path) else {
            return
        }
        self.logFileHandle = logFileHandle
    }

    public func doLog(_ logEntry: LogEntry) {
        self.logFileHandle?.write("\n\(logEntry.logLevel.text) \(logEntry.metaText)\(logEntry.text)".data(using: .utf8)!)
    }

}
