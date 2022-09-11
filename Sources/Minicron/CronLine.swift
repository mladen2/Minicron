//
//  CronLine.swift
//  Minicron
//
//  Created by devs on 07/09/2022.
//

import Foundation

struct CronLine {
    var minutes: String
    var minutesInt: Int? { Int(minutes) }
    var hour: String
    var hourInt: Int? { Int(hour) }
    var command: String
    
    var isNumbers: Bool {
        isValidHour(hour) && isValidMinutes(minutes)
    }
    
    var time: String {
        isNumbers ? "\(hour):\(minutes)" : .empty
    }
    
    var outputLine: String {
        .empty
    }
}

extension CronLine {
    init?(_ line: String) {
        let comps = line.components(separatedBy: " ")
        guard comps.count > 0 else { return nil }
        minutes = comps[0]
        guard asteriskOrMinutes(minutes) else { return nil }
        
        guard comps.count > 1 else { return nil }
        hour = comps[1]
        guard asteriskOrHour(hour) else { return nil }
        
        guard comps.count > 2 else { return nil }
        command = comps[2]
        guard !command.isEmpty else { return nil }
    }
}

extension CronLine {
    var description: String {
        "hour: \(hour), minutes: \(minutes), command: \(command)"
    }
}

func asteriskOrMinutes(_ input: String) -> Bool {
    guard input != .asterisk else { return true }
    return isValidMinutes(input)
}

func isValidMinutes(_ input: String) -> Bool {
    guard let inputValue = Int(input) else { return false }
    return inputValue >= 0 && inputValue < 60
}

func asteriskOrHour(_ input: String) -> Bool {
    guard input != .asterisk else { return true }
    return isValidHour(input)
}

func isValidHour(_ input: String) -> Bool {
    guard let inputValue = Int(input) else { return false }
    return inputValue >= 0 && inputValue < 24
}
