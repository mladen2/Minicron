//
//  ArgumentsTests.swift
//  
//
//  Created by devs on 11/09/2022.
//

import XCTest
@testable import Minicron

final class ArgumentsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_main_harness() throws {
        let main = MainHarness(arguments: ["", "16:10"], runner: RunnerMock())
        XCTAssertNotNil(main)
    }
    
    func test_main_harness_given_time() throws {
        let main = MainHarness(arguments: ["", "16:10"], runner: RunnerMock())
        XCTAssertNotNil(main)
        try? main.run()
        XCTAssert(main.runner.hhmm == "16:10", "\(String(describing: main.runner.hhmm))")
    }
    
    func test_main_harness_given_time_2() throws {
        let main = MainHarness(arguments: ["", "16:10"], runner: RunnerMock())
        XCTAssertNotNil(main)
        try? main.run()
        XCTAssertFalse(main.runner.hhmm == "16:11", "\(String(describing: main.runner.hhmm))")
    }

}
