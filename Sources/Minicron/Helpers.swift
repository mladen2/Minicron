//
//  File.swift
//  
//
//  Created by devs on 10/09/2022.
//

import Foundation

private func fmtd(_ date: Date) -> String {
    let df = DateFormatter()
    df.dateFormat = "HH:mm:ss.SSS"
    return df.string(from: date)
}

func pr(date: Date = Date(), file: String = #file, function: String = #function, line: Int = #line, _ message: String = .empty) {
    guard DEBUG else { return }
    var file = file.components(separatedBy: String.slash).last ?? .empty
    file = file.replacingOccurrences(of: String.swiftSuffix, with: String.empty)
    print("\(fmtd(date)) \(file) \(function):\(line) \(message)")
}

func pr(_ error: MyError, message: String = .empty) {
    print(String.newLine)
    print("Error: \(error)")
    print(String.newLine)
    print("\(message)")
    print(String.newLine)
}
