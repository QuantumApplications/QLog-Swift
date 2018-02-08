//
//  LogEntry.swift
//  QLog
//
//  Created by Christian Oberdörfer on 07.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

public struct LogEntry {

    let date: Date
    let file: String
    let function: String
    let line: Int
    let logLevel: LogLevel
    let text: String

    var metaText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return "\(dateFormatter.string(from: self.date)): \((self.file as NSString).lastPathComponent):\(self.line) \(self.function): "
    }

}
