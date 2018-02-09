//
//  FileLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 09.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

public class FileLogger: Logger {

    let logUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log")
    var logFileHandle: FileHandle?

    public override init(logLevel: LogLevel = .debug) {
        super.init(logLevel: logLevel)
        // Prepare log path
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let logDirectoryUrl = self.logUrl.appendingPathComponent(appName)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let logFileName = dateFormatter.string(from: Date()) + ".log"
        let logFileUrl = logDirectoryUrl.appendingPathComponent(logFileName)
        try? FileManager.default.createDirectory(at: logDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
        if FileManager.default.createFile(atPath: logFileUrl.path, contents: nil, attributes: nil) {
            if let logFileHandle = FileHandle(forWritingAtPath: logFileUrl.path) {
                self.logFileHandle = logFileHandle
            }
        }
    }

    override func doLog(_ logEntry: LogEntry) {
        self.logFileHandle?.write("\n\(logEntry.metaText)\(logEntry.text)".data(using: .utf8)!)
    }

}
