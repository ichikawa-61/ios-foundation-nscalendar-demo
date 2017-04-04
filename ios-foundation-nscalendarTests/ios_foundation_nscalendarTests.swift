//
//  ios_foundation_nscalendarTests.swift
//  ios-foundation-nscalendarTests
//
//  Created by Kushida　Eiji on 2017/02/05.
//  Copyright © 2017年 Kushida　Eiji. All rights reserved.
//

import XCTest
@testable import ios_foundation_nscalendar

class ios_foundation_nscalendarTests: XCTestCase {
    
    private let tokyoTimeZone = "Asia/Tokyo"
    private let jpLocal = "ja"
    private var calendar = NSCalendar.current
    private let helper = CalendarHelper()

    override func setUp() {
        super.setUp()
        helper.setLocal(local: jpLocal)
        helper.setTimeZone(timeZone: tokyoTimeZone)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// 年を取得する
    func testDateYear() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        XCTAssertEqual(helper.dateYear(date: date), 2017)
    }
    
    /// 月を取得する
    func testDateMonth() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        XCTAssertEqual(helper.dateMonth(date: date), 1)
    }

    /// 日を取得する
    func testDateDay() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        XCTAssertEqual(helper.dateDay(date: date), 2)
    }

    /// 時間を取得する
    func testDateHour() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        XCTAssertEqual(helper.dateHour(date: date), 3)
    }

    /// 分を取得する
    func testDateMinite() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        XCTAssertEqual(helper.dateMinute(date: date), 4)
    }
    
    /// 曜日を取得する
    func testDateWeekDay() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        let weekDayIndex = helper.dateWeekDay(date: date)
        let weekDays = helper.renderShortWeekdaySymbols()
        XCTAssertEqual(weekDays[weekDayIndex], "火")
    }
    
    /// 経過時間を取得する（秒）
    /// check : 60秒経過したか？
    func testDateDiffForSecond() {
        
        let fromDate = str2Date(dateStr: "2017/1/2 3:1")
        let toDate = str2Date(dateStr: "2017/1/2 3:2")
        XCTAssertEqual(helper.passTimeBySecond(fromDate: fromDate, toDate: toDate), 60)
    }
    
    /// 経過時間を取得する（分）
    /// check: 24時間経過したか？
    func testDateDiffForMinute() {
        
        let fromDate = str2Date(dateStr: "2017/1/2 3:1")
        let toDate = str2Date(dateStr: "2017/1/3 3:1")
        XCTAssertEqual(helper.passTimeByMinitue(fromDate: fromDate, toDate: toDate), 24 * 60)
    }
    
    /// 経過時間を取得する（日）
    /// check: 10日間経過したか？
    func testDateDiffForDay() {
        
        let fromDate = str2Date(dateStr: "2017/1/2 3:1")
        let toDate = str2Date(dateStr: "2017/1/12 3:2")
        XCTAssertEqual(helper.passTimeByDay(fromDate: fromDate, toDate: toDate), 10)
    }
    
    /// 年月日が同じか？（時分秒まで同じ）
    func testSameDateTime() {
        
        let fromDate = str2Date(dateStr: "2017/1/12 10:10")
        let toDate = str2Date(dateStr: "2017/1/12 10:10")
        XCTAssertTrue(fromDate == toDate)
    }
    
    /// 同年か？（月日、時間は関係ない）
    func testSameYear() {
        
        let fromDate = str2Date(dateStr: "2017/1/1 1:1")
        let toDate = str2Date(dateStr: "2017/1/12 10:10")
        XCTAssertTrue(helper.isSameYear(fromDate: fromDate, toDate: toDate))
    }
    
    /// 同年、月か？（日、時間は関係ない）
    func testSameMonth() {
        
        let fromDate = str2Date(dateStr: "2017/1/1 1:1")
        let toDate = str2Date(dateStr: "2017/1/12 10:10")
        XCTAssertTrue(helper.isSameMonth(fromDate: fromDate, toDate: toDate))
    }
    
    /// 年月日が同じか？ (時間は関係ない）
    func testSameDate() {
        
        let fromDate = str2Date(dateStr: "2017/1/12 5:5")
        let toDate = str2Date(dateStr: "2017/1/12 10:10")
        XCTAssertTrue(helper.isSameDate(fromDate: fromDate, toDate: toDate))
    }

    //MARK:Helper
    func str2Date(dateStr: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP");
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: dateStr)!
    }
    
}
