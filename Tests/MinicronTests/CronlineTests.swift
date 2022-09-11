import XCTest
@testable import Minicron

// Min Hour Command
// 30 1 /bin/command

final class CronlineTests: XCTestCase {
    
}
    

    // MARK: - cron input valid
extension CronlineTests {
    
    func test_cronline() throws {
        let cronline = CronLine("* * *")
        XCTAssertNotNil(cronline, "cronline is nil")
        XCTAssert(cronline!.hour == .asterisk)
        XCTAssert(cronline!.minutes == .asterisk)
        XCTAssert(cronline!.command == .asterisk)
    }
    
    func test_cronline_hm() throws {
        let cronline = CronLine("30 1 /bin/run_me_daily")
        XCTAssertNotNil(cronline, "cronline is nil")
        XCTAssert(cronline!.minutes == "30")
        XCTAssert(cronline!.hour == "1")
        XCTAssert(cronline!.command == "/bin/run_me_daily")
    }
    
    func test_cronline_min_only() throws {
        let cronline = CronLine("45 * /bin/run_me_hourly")
        XCTAssertNotNil(cronline, "cronline is nil")
        XCTAssert(cronline!.minutes == "45")
        XCTAssert(cronline!.hour == "*")
        XCTAssert(cronline!.command == "/bin/run_me_hourly")
    }
    
    func test_cronline_every_minute() throws {
        let cronline = CronLine("* * /bin/run_me_every_minute")
        XCTAssertNotNil(cronline, "cronline is nil")
        XCTAssert(cronline!.minutes == "*")
        XCTAssert(cronline!.hour == "*")
        XCTAssert(cronline!.command == "/bin/run_me_every_minute")
    }
    
    func test_cronline_sixty_times() throws {
        let cronline = CronLine("* 19 /bin/run_me_sixty_times")
        XCTAssertNotNil(cronline, "cronline is nil")
        XCTAssert(cronline!.minutes == "*")
        XCTAssert(cronline!.hour == "19")
        XCTAssert(cronline!.command == "/bin/run_me_sixty_times")
    }
}
    
// MARK: - cron input invalid
extension CronlineTests {
    
    func test_cronline_invalid_minute() throws {
        let cronline = CronLine("77 1 /bin/run_me_daily")
        XCTAssertNil(cronline, "cronline is nil")
    }
    
    func test_cronline_invalid_hour() throws {
        let cronline = CronLine("12 88 /bin/run_me_daily")
        XCTAssertNil(cronline, "cronline is nil")
    }
    
    func test_cronline_invalid_no_command() throws {
        let cronline = CronLine("12 88")
        XCTAssertNil(cronline, "cronline is nil")
    }
    
    func test_cronline_invalid_one_arg() throws {
        let cronline = CronLine("12")
        XCTAssertNil(cronline, "cronline is nil")
    }
}

// MARK: - cron output
extension CronlineTests {
    
    func test_cron_output() throws {
        let cron = CronOutput(time: .empty, day: .today, command: .empty)
        XCTAssertNotNil(cron, "cronline is nil")
        XCTAssertEqual(cron.description, " today - ")
    }
    
    func test_cron_output_tomorrow() throws {
        let cron = CronOutput(time: .empty, day: .tomorrow, command: .empty)
        XCTAssertNotNil(cron, "cronline is nil")
        XCTAssertEqual(cron.description, " tomorrow - ")
    }
    
    func test_cron_output_full() throws {
        let cron = CronOutput(time: "11:45", day: .tomorrow, command: "/bin/execute_command")
        XCTAssertNotNil(cron, "cronline is nil")
        XCTAssertEqual(cron.description, "11:45 tomorrow - /bin/execute_command")
    }
}
