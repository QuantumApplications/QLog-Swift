//
//  LogEntry.swift
//  QLog
//
//  Created by Christian Oberdörfer on 07.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

public struct LogEntry: Equatable {

    let date: Date
    let file: String
    let function: String
    let line: Int
    let logLevel: LogLevel
    let text: String

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }()

    var metaText: String {
        return "\(LogEntry.dateFormatter.string(from: self.date)): \(URL(fileURLWithPath: self.file).lastPathComponent):\(self.line) \(self.function): "
    }

}

public func == (lhs: LogEntry, rhs: LogEntry) -> Bool {
    return lhs.date == rhs.date &&
        lhs.file == rhs.file &&
        lhs.function == rhs.function &&
        lhs.line == rhs.line &&
        lhs.logLevel == rhs.logLevel &&
        lhs.text == rhs.text
}
