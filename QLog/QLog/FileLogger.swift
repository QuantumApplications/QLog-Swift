//
//  FileLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 09.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

extension LogLevel {

    /// Associates a string with each log level
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

/**
 Logger to log into file.
 For each target of the application (host app, share extension etc.)
 a new subdirectory is created.
 For each start of the application a new log file is created in this subdirectory.
 */
public class FileLogger: Logger {

    public var logLevel: LogLevel = .info

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    /// The name of the target (host app, share extension etc.)
    private static let targetName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Application"

    private let logFileHandle: FileHandle?
    private let logUrl: URL

    /**
     Creates a new file logger with a new log file.
     The log file is stored in a subdirectory for the target name.
     The subdirectory is stored at the log url.
     - parameter logLevel: The log level. Default is info.
     - parameter logUrl: The URL to store the log data at. Default is "log" in documents directory.
     */
    public init(logLevel: LogLevel = .info, logUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")) {
        self.logLevel = logLevel
        self.logUrl = logUrl
        let logDirectoryUrl = self.logUrl.appendingPathComponent(FileLogger.targetName)
        let logFileName = FileLogger.dateFormatter.string(from: Date()) + ".log"
        let logFileUrl = logDirectoryUrl.appendingPathComponent(logFileName)
        try? FileManager.default.createDirectory(at: logDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
        FileManager.default.createFile(atPath: logFileUrl.path, contents: nil, attributes: nil)
        self.logFileHandle = FileHandle(forWritingAtPath: logFileUrl.path)
    }

    public func doLog(_ logEntry: LogEntry) {
        self.logFileHandle?.write("\n\(logEntry.logLevel.text) \(logEntry.metaText)\(logEntry.text)".data(using: .utf8)!)
    }

}
