//
//  RulesClass.swift
//  Minicron
//
//  Created by devs on 07/09/2022.
//

import Foundation

enum RunDay: String {
    case today, tomorrow
}

final class Rules {
    
    func findNextRun(_ cronLine: CronLine, givenTime: Date) -> CronOutput? {
        
        if cronLine.isNumbers {
            return specificTime(for: cronLine, givenTime: givenTime)
        }
        
        if cronLine.minutesInt != nil {
            return specificMinute(for: cronLine, givenTime: givenTime)
        }

        if cronLine.hourInt != nil {
            return specificHour(for: cronLine, givenTime: givenTime)
        }

        return everyMinute(for: cronLine, givenTime: givenTime)
    }
    
    func specificTime(for cronLine: CronLine, givenTime: Date) -> CronOutput? {
        pr("specificTime")
        
        // same date
        var lineDateComponents = Calendar.current.dateComponents([.hour, .minute, .day, .month, .year], from: Date())
        lineDateComponents.hour = cronLine.hourInt
        lineDateComponents.minute = cronLine.minutesInt
        pr("lineDateComponents: \(lineDateComponents)")
        
        guard let lineDate = Calendar.current.date(from: lineDateComponents) else { return nil }
        let runDay: RunDay = lineDate < givenTime ? .tomorrow : .today
        let out = CronOutput(time: lineDate, day: runDay, command: cronLine.command)
        pr("out: \(out.description)")
        return out
    }
    
    /// every hour at x minutes
    ///  off by one
    ///      /// i.e. this or next hour
    func specificMinute(for cronLine: CronLine, givenTime: Date) -> CronOutput? {
        
        pr("specificMinute")
        let givenTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: givenTime)
        guard let givenMinutes = givenTimeComponents.minute else { return nil }
        guard let givenHour = givenTimeComponents.hour else { return nil }
        guard let lineMinutes = cronLine.minutesInt else { return nil }
        
        if lineMinutes < givenMinutes {
            // next hour
            var nextHour = givenHour + 1
            if nextHour > 23 {
                nextHour = 0
                if let today = Calendar.current.date(bySettingHour: nextHour, minute: lineMinutes, second: 0, of: Date()),
                   let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today) {
                    let out = CronOutput(time: tomorrow, day: .tomorrow, command: cronLine.command)
                    pr("out: \(out.description)")
                    return out
                }
            } else {
                if let today = Calendar.current.date(bySettingHour: nextHour, minute: lineMinutes, second: 0, of: Date()) {
                    let out = CronOutput(time: today, day: .today, command: cronLine.command)
                    pr("out: \(out.description)")
                    return out
                }
            }
        } else {
            // this hour, today
            if let today = Calendar.current.date(bySettingHour: givenHour, minute: lineMinutes, second: 0, of: Date()) {
                let out = CronOutput(time: today, day: .today, command: cronLine.command)
                pr("out: \(out.description)")
                return out
            }
        }
        return nil
    }
    
    // every minute of the given hour
    func specificHour(for cronLine: CronLine, givenTime: Date) -> CronOutput? {
        
        pr("specificHour \(givenTime)")
        
        var givenTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: givenTime)
        guard let givenHour = givenTimeComponents.hour else { return nil }
        guard let givenMinutes = givenTimeComponents.minute else { return nil }
        guard let lineHour = cronLine.hourInt else { return nil }
        
        // same hour, next minute
        if lineHour == givenHour {
            if givenMinutes < 59 {
                return CronOutput(time: givenTime, day: .today, command: cronLine.command)
            } else {
                // 59
            }
        }
        
        // is given hour before or after line hour?
        
        // before? today, first minute of the line hour
        if givenHour < lineHour {
            givenTimeComponents.minute = 0
            givenTimeComponents.hour = lineHour
            guard let nextTime = Calendar.current.date(from: givenTimeComponents) else { return nil }
            return CronOutput(time: nextTime, day: .today, command: cronLine.command)
        }
        
        // after, tomorrow, first minute of the line hour
        if givenHour > lineHour {
            givenTimeComponents.minute = 0
            givenTimeComponents.hour = lineHour
            guard let nextTime = Calendar.current.nextDate(after: givenTime, matching: givenTimeComponents, matchingPolicy: Calendar.MatchingPolicy.nextTime) else { return nil }
            return CronOutput(time: nextTime, day: .tomorrow, command: cronLine.command)
        }
        
        return nil
    }
    
    func everyMinute(for cronLine: CronLine, givenTime: Date) -> CronOutput? {
        pr("nextMinute givenTime: \(givenTime)")
        // if the required output is the current minute, i.e. 16:10 then we take the current time 16:10
        // but if cron does not start until the next whole minute then we should be this
//        guard let nextMinute = Calendar.current.date(byAdding: .minute, value: 1, to: currentTime) else { return nil }
        let nextMinute = givenTime
        if Calendar.current.isDateInToday(nextMinute) {
            return CronOutput(time: givenTime, day: .today, command: cronLine.command)
        }
        return nil
    }
}
