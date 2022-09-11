//
//  File.swift
//  
//
//  Created by devs on 11/09/2022.
//

import Foundation

final class CronOutput {
    var time: String = ""
    var day: RunDay = .today
    var command: String = ""
    
    init(time: String, day: RunDay, command: String) {
        self.time = time
        self.day = day
        self.command = command
    }
    
    init(time: Date, day: RunDay, command: String) {
        pr("time: \(time)")
        self.time = DateFormatter.inputDateFormat(time)
        pr("self.time: \(self.time)")
        self.day = day
        self.command = command
    }

    var description: String {
        "\(time) \(day.rawValue) - \(command)"
    }
}
