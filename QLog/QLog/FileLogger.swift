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

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    static let targetName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Application"

    let logFileHandle: FileHandle?
    let logUrl: URL

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
