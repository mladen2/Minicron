//
//  File.swift
//  
//
//  Created by devs on 11/09/2022.
//

import Foundation

protocol Runnable {
    var cronlines: [CronLine] { get set }
    var givenTime: Date? { get set }
    var hhmm: String? { get }
    func addCronLine(_ line: String)
    func run() -> String
}

final class RunnerMock: Runnable {
    var cronlines: [CronLine]
    var givenTime: Date?
    var hhmm: String?
    
    init(cronline: String, givenTime: Date?) {
        self.givenTime = givenTime
        cronlines = []
        addCronLine(cronline)
    }

    init() {
        let hhmm: String = .sixteenTen
        self.givenTime = Date()
        self.cronlines = [
            CronLine(minutes: "1", hour: "1", command: "/bin/run_me_every_minute")
        ]
        self.hhmm = hhmm
    }
    
    func addCronLine(_ line: String) {
        guard !line.trimmingCharacters(in: .whitespacesAndNewlines).hasPrefix(.comment) else {
            return
        }
        
        if let cronLine = CronLine(line) {
            cronlines.append(cronLine)
        }
    }
    
    func run() -> String {
        guard let givenTime = givenTime else { return .empty }
        var outputString = ""
        for cronLine in cronlines {
            pr("\(cronLine.description)")
            guard let cronOutput = Rules().findNextRun(cronLine, givenTime: givenTime) else {
                continue
            }
            outputString += cronOutput.description + .newLine
        }
        return outputString
    }
}
