//
//  main.swift
//  Minicron
//
//  Created by devs on 07/09/2022.
//

import Foundation

let DEBUG = false

private func appName(_ arg: String) -> String {
    arg.components(separatedBy: String.slash).last ?? .empty
}

let usage = "Usage: cat input.txt | \(appName(CommandLine.arguments[0])) <HH:mm>"

final class MainHarness {
    
    private let arguments: [String]
    var runner: Runnable

    public init(arguments: [String] = CommandLine.arguments, runner: Runnable) {
        self.arguments = arguments
        self.runner = runner
    }

    public func run() throws {
        guard let ret = processArguments() else {
            let output = runner.run()
            print(output)
            return
        }
        throw ret
    }
    
    func processArguments() -> MyError? {
        var hhmm = ""
        
        guard arguments.count > 1 else {
            pr(.tooFewArguments, message: usage)
            return .tooFewArguments
        }
        
        hhmm = arguments[1]
        pr("Current Time: \(hhmm)")

        let timeComps = hhmm.components(separatedBy: String.colon)

        guard timeComps.count == 2,
              let givenHour = Int(timeComps[0]),
              isValidHour(timeComps[0]),
              let givenMinutes = Int(timeComps[1]),
              isValidMinutes(timeComps[1]) else {
            pr(.incorrectTimeFormat, message: usage)
            return .incorrectTimeFormat
        }
        
        
        pr("given hour: \(givenHour)")
        pr("given minutes: \(givenMinutes)")

        let calendar = Calendar.current

        var givenTimeComponents = calendar.dateComponents([.hour, .minute, .day, .month, .year], from: Date())
        givenTimeComponents.hour = givenHour
        givenTimeComponents.minute = givenMinutes

        guard let givenTime = calendar.date(from: givenTimeComponents) else {
            pr(.incorrectTimeFormat, message: "Unable to create date from \(givenTimeComponents)")
            return.incorrectTimeFormat
        }
        
        runner.givenTime = givenTime
        
        return nil
    }

}





