//
//  Constants.swift
//  Minicron
//
//  Created by devs on 07/09/2022.
//

import Foundation

extension String {
    static let asterisk = "*"
    static let colon = ":"
    static let comment = "#"
    static let empty = ""
    static let inputTimeFormat = "HH:mm"
    static let newLine = "\n"
    static let sixteenTen = "16:10"
    static let slash = "/"
    static let swiftSuffix = ".swift"
}

let input_txt = """
30 1 /bin/run_me_daily
45 * /bin/run_me_hourly
* * /bin/run_me_every_minute
* 19 /bin/run_me_sixty_times
"""

let input_txt_back = """
30 1 /bin/run_me_daily
45 * /bin/run_me_hourly
* * /bin/run_me_every_minute
* 19 /bin/run_me_sixty_times
"""

let error_text = """
30 1/bin/run_me_daily
45 * /bin/run_me_hourly
* *  ath  /bin/run_me_every_minute
/bin/run_me_sixty_times
"""

