//
//  ProcessTests.swift
//  
//
//  Created by devs on 11/09/2022.
//

import XCTest
@testable import Minicron

// outputs
private extension String {
    static let _1610_output = "16:10 today - /bin/run_me_every_minute"
    static let _30_1_output = "01:30 tomorrow - /bin/run_me_daily"
    static let _45__output = "16:45 today - /bin/run_me_hourly"
    static let _19_60_times_output = "19:00 today - /bin/run_me_sixty_times"
    static let every_minute_output = "16:10 today - /bin/run_me_every_minute"
    // 23
    static let _23h_19_60_times_output = "19:00 tomorrow - /bin/run_me_sixty_times"
    static let _23h_every_minute_output = "23:10 today - /bin/run_me_every_minute"
    static let _23h_45__output = "23:45 today - /bin/run_me_hourly"
    
    //5:30 output
    static let _0530_45__output = "05:45 today - /bin/run_me_hourly"
    static let _0530_19_60_times_output = "19:00 today - /bin/run_me_sixty_times"
    static let _0530_every_minute_output = "05:30 today - /bin/run_me_every_minute"
}

// inputs
private extension String {
    static let _30_1_input = "30 1 /bin/run_me_daily"
    static let _45__input = "45 * /bin/run_me_hourly"
    static let _19_60_times_input = "* 19 /bin/run_me_sixty_times"
    static let every_minute_input = "* * /bin/run_me_every_minute"
    
    static let _2310_19_60_times_input = "* 19 /bin/run_me_sixty_times"
}

final class ProcessTests: XCTestCase {
    
    private var givenTime: Date?
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func time(with hour: Int, minute: Int) -> Date? {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = 0
        return Calendar.current.date(from: dateComponents)
    }
}

// MARK: - 16:10
extension ProcessTests {
    func test_process_exact_time() throws {
        givenTime = time(with: 16, minute: 10)
        let runner = RunnerMock(cronline: ._30_1_input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(String._30_1_output)
        XCTAssertEqual(output, ._30_1_output)
    }
    
    func test_process_minutes_only() throws {
        givenTime = time(with: 16, minute: 10)
        pr("in line: \(String._45__input)")
        let runner = RunnerMock(cronline: ._45__input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(String._45__output)
        XCTAssertEqual(output, ._45__output)
    }
    
    func test_process_60_times() throws {
        givenTime = time(with: 16, minute: 10)
        pr("in line: \(String._19_60_times_input)")
        let runner = RunnerMock(cronline: ._19_60_times_input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(String._19_60_times_output)
        XCTAssertEqual(output, ._19_60_times_output)
    }
    
    func test_process_every_minute() throws {
        givenTime = time(with: 16, minute: 10)
        pr("in line: \(String.every_minute_input)")
        let runner = RunnerMock(cronline: .every_minute_input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(String.every_minute_output)
        XCTAssertEqual(output, .every_minute_output)
    }
}

// MARK: - 23:10
extension ProcessTests {
    func test_process_exact_time_23() throws {
        givenTime = time(with: 23, minute: 10)
        let runner = RunnerMock(cronline: ._30_1_input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(String._30_1_output)
        XCTAssertEqual(output, ._30_1_output)
    }

    func test_process_minutes_only_23() throws {
        let input: String = ._45__input
        let expectedOutput: String = ._23h_45__output

        givenTime = time(with: 23, minute: 10)
        pr("in line: \(input)")
        let runner = RunnerMock(cronline: input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(expectedOutput)
        XCTAssertEqual(output, expectedOutput)
    }

    func test_process_60_times_23() throws {
        
        let input: String = ._2310_19_60_times_input
        let expectedOutput: String = ._23h_19_60_times_output
        
        givenTime = time(with: 23, minute: 10)
        pr("in line: \(input)")
        let runner = RunnerMock(cronline: input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(expectedOutput)
        XCTAssertEqual(output, expectedOutput)
    }

    func test_process_every_minute_23() throws {
        let input: String = .every_minute_input
        let expectedOutput: String = ._23h_every_minute_output
        
        givenTime = time(with: 23, minute: 10)
        pr("in line: \(input)")
        let runner = RunnerMock(cronline: input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(expectedOutput)
        XCTAssertEqual(output, expectedOutput)
    }
}

// MARK: - 5:30
extension ProcessTests {
    func test_process_exact_time_5_30() throws {
        givenTime = time(with: 5, minute: 30)
        let runner = RunnerMock(cronline: ._30_1_input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(String._30_1_output)
        XCTAssertEqual(output, ._30_1_output)
    }

    func test_process_minutes_only_5_30() throws {
        let input: String = ._45__input
        let expectedOutput: String = ._0530_45__output

        givenTime = time(with: 5, minute: 30)
        pr("in line: \(input)")
        let runner = RunnerMock(cronline: input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(expectedOutput)
        XCTAssertEqual(output, expectedOutput)
    }

    func test_process_60_times_5_30() throws {
        
        let input: String = ._2310_19_60_times_input
        let expectedOutput: String = ._0530_19_60_times_output
        
        givenTime = time(with: 5, minute: 30)
        pr("in line: \(input)")
        let runner = RunnerMock(cronline: input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(expectedOutput)
        XCTAssertEqual(output, expectedOutput)
    }

    func test_process_every_minute_5_30() throws {
        let input: String = .every_minute_input
        let expectedOutput: String = ._0530_every_minute_output
        
        givenTime = time(with: 5, minute: 30)
        pr("in line: \(input)")
        let runner = RunnerMock(cronline: input, givenTime: givenTime)
        XCTAssertNotNil(runner)
        let output = runner.run().trimmingCharacters(in: .whitespacesAndNewlines)
        print("\(output)")
        print(expectedOutput)
        XCTAssertEqual(output, expectedOutput)
    }
}
