//
//  File.swift
//  
//
//  Created by devs on 10/09/2022.
//

import Foundation

extension DateFormatter {
    static func inputDateFormat(_ date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = .inputTimeFormat
        return df.string(from: date)
    }
}

final class Runner: Runnable {
    
    static let shared = Runner()
    
    var cronlines: [CronLine]
    var givenTime: Date?
    var hhmm: String? {
        guard let givenTime = givenTime else { return .empty }
        return DateFormatter.inputDateFormat(givenTime)
    }

    init(cronLines: [CronLine] = [CronLine](), givenTime: Date? = nil) {
        self.cronlines = cronLines
        self.givenTime = givenTime
    }
    
    func addCronLine(_ line: String) {
        guard !line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).hasPrefix(.comment) else {
            return
        }
        
        if let cronLine = CronLine(line) {
            cronlines.append(cronLine)
        }
    }
    
    // main processing loop
    func run() -> String {
        
        guard let givenTime = givenTime else { return .empty }
        
        var count = 1

        while let line = readLine() {
            guard !line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).hasPrefix(.comment) else {
                continue
            }
            
            if let cronLine = CronLine(line) {
                cronlines.append(cronLine)
            } else {
                print("Format error at line: \(count). \(line)")
            }
            count += 1
        }
        
        pr("Process")
        
        var outputString = ""
        for cronLine in cronlines {
            pr("Command: \(cronLine.command)")
            pr(cronLine.description)
            guard let cronOutput = Rules().findNextRun(cronLine, givenTime: givenTime) else {
                continue
            }
            outputString += cronOutput.description + .newLine
        }
        return outputString
    }
}
