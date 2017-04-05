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
    private let jpLocale = "ja"
    private let helper = CalendarHelper()

    override func setUp() {
        super.setUp()
        helper.setlocale(locale: jpLocale)
        helper.setTimeZone(timeZone: tokyoTimeZone)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// 年を取得できるか？
    /// check : 2017
    func testDateYear() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        XCTAssertEqual(helper.dateYear(date: date), 2017)
    }
    
    /// 月を取得できるか？
    /// check : 1
    func testDateMonth() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        XCTAssertEqual(helper.dateMonth(date: date), 1)
    }

    /// 日を取得できるか？
    /// check : 2
    func testDateDay() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        XCTAssertEqual(helper.dateDay(date: date), 2)
    }

    /// 時間を取得できるか？
    /// check : 3
    func testDateHour() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        XCTAssertEqual(helper.dateHour(date: date), 3)
    }

    /// 分を取得できるか？
    /// check : 4
    func testDateMinite() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        XCTAssertEqual(helper.dateMinute(date: date), 4)
    }
    
    /// 曜日を取得できるか？
    /// check : 火
    func testDateWeekDay() {
        let date = str2Date(dateStr: "2017/1/2 3:4")
        let weekDayIndex = helper.dateWeekDay(date: date)
        let weekDays = helper.renderShortWeekdaySymbols()
        XCTAssertEqual(weekDays[weekDayIndex], "火")
    }
    
    /// 経過時間が秒単位で取得できるか？
    /// check : 60秒経過したか？
    func testDateDiffForSecond() {
        
        let fromDate = str2Date(dateStr: "2017/1/2 3:1")
        let toDate = str2Date(dateStr: "2017/1/2 3:2")
        XCTAssertEqual(helper.passTimeBySecond(fromDate: fromDate, toDate: toDate), 60)
    }
    
    /// 経過時間が分単位で取得できるか？
    /// check: 24時間経過したか？
    func testDateDiffForMinute() {
        
        let fromDate = str2Date(dateStr: "2017/1/2 3:1")
        let toDate = str2Date(dateStr: "2017/1/3 3:1")
        XCTAssertEqual(helper.passTimeByMinitue(fromDate: fromDate, toDate: toDate), 24 * 60)
    }
    
    /// 経過時間が日単位で取得できるか？
    /// check: 7日間経過したか？
    func testDateDiffForDay() {
        
        let fromDate = str2Date(dateStr: "2017/1/2 3:1")
        let toDate = str2Date(dateStr: "2017/1/9 3:2")
        XCTAssertEqual(helper.passTimeByDay(fromDate: fromDate, toDate: toDate), 7)
    }
    
    /// 年月日が同じか？（時分秒まで同じ）
    func testSameDateTime() {
        
        let fromDate = str2Date(dateStr: "2017/1/12 10:10")
        let toDate = str2Date(dateStr: "2017/1/12 10:10")
        XCTAssertTrue(fromDate == toDate)
    }
    
    /// 年が同じか？（月日、時間は関係ない）
    func testSameYear() {
        
        let fromDate = str2Date(dateStr: "2017/1/1 1:1")
        let toDate = str2Date(dateStr: "2017/1/12 10:10")
        XCTAssertTrue(helper.isSameYear(fromDate: fromDate, toDate: toDate))
    }
    
    /// 年月が同じか？（日、時間は関係ない）
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
    
    /// 該当付きの月初は何日か？
    /// check : 2017/01/01
    func testStartOfMonth() {
        
        let fromDate = str2Date(dateStr: "2017/1/12 5:5")
        let startOfDay = helper.startOfMonthDay(date: fromDate)
        XCTAssertEqual(str2Date(date: startOfDay!, format: "yyyy/MM/dd"), "2017/01/01")
    }
    
    /// 該当付きの月末は何日か？
    /// check : 2017/01/31
    func testEndOfMonth() {
        
        let fromDate = str2Date(dateStr: "2017/1/12 5:5")
        let endOfDay = helper.endOfMonthDay(date: fromDate)
        XCTAssertEqual(str2Date(date: endOfDay!, format: "yyyy/MM/dd"), "2017/01/31")
    }
    
    /// 月の文字列一覧を取得する
    /// check : 1月、2月、3月、4月、5月、6月、7月、8月、9月、10月、11月、12月
    func testRenderMonthSymbols() {
        
        let monthSymbols = helper.renderMonthSymbols()
        
        verifyMonth(count: monthSymbols.count,
                    months: monthSymbols) { (months) -> Bool in
                        months.contains("1月") && months.contains("2月") &&
                            months.contains("3月") && months.contains("4月") &&
                            months.contains("5月") && months.contains("6月") &&
                            months.contains("7月") && months.contains("8月") &&
                            months.contains("9月") && months.contains("10月") &&
                            months.contains("11月") && months.contains("12月")
        }
    }
    
    /// 週の文字列一覧を取得する
    /// check : 月曜日、火曜日、水曜日、木曜日、金曜日、土曜日、日曜日
    func testRenderWeekdaySymbols() {
        
        let weekdaySymbols = helper.renderWeekdaySymbols()
        
        verifyWeek(count: weekdaySymbols.count,
                   weeks: weekdaySymbols) { (weeks) -> Bool in
                    
                    weeks.contains("月曜日") && weeks.contains("火曜日") &&
                    weeks.contains("水曜日") && weeks.contains("木曜日") &&
                    weeks.contains("金曜日") && weeks.contains("土曜日") &&
                    weeks.contains("日曜日")
        }
    }
    
    /// 週の文字列一覧を取得する
    /// check : 月、火、水、木、金、土、日
    func testRenderShortWeekdaySymbols() {
        
        let weekdaySymbols = helper.renderShortWeekdaySymbols()
        
        verifyWeek(count: weekdaySymbols.count,
                   weeks: weekdaySymbols) { (weeks) -> Bool in
                    
                    weeks.contains("月") && weeks.contains("火") &&
                    weeks.contains("水") && weeks.contains("木") &&
                    weeks.contains("金") && weeks.contains("土") &&
                    weeks.contains("日")
        }
    }

    //MARK:Helper
    /// 文字列を日付型に変換する
    ///
    /// - Parameter dateStr: 日付の文字列
    /// - Returns: 日付型のデータ
    func str2Date(dateStr: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP");
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: dateStr)!
    }
    
    /// 日付型を文字列に変換する
    ///
    /// - Parameters:
    ///   - date: 日付データ
    ///   - format: 日付の書式
    /// - Returns: 日付の文字列
    func str2Date(date: Date, format: String) -> String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP");
        formatter.dateFormat = format
        return formatter.string(from:date)
    }
    
    /// 月の文字列一覧確認用のヘルパー
    ///
    /// - Parameters:
    ///   - count: 件数
    ///   - months: 月の文字列一覧
    ///   - extrasMatcher: 比較パターン
    func verifyMonth(count: Int,
                     months: [String],
                     extrasMatcher: (([String]) -> Bool)) {
        
        XCTAssertEqual(count, 12)
        XCTAssertTrue(extrasMatcher(months),
                      "extras was \(months)")
    }
    
    /// 週の文字列一覧確認用のヘルパー
    ///
    /// - Parameters:
    ///   - count: データ件数
    ///   - weeks: 週の文字列一覧
    ///   - extrasMatcher: 比較パターン
    func verifyWeek(count: Int,
                     weeks: [String],
                     extrasMatcher: (([String]) -> Bool)) {
        
        XCTAssertEqual(count, 7)
        XCTAssertTrue(extrasMatcher(weeks),
                      "extras was \(weeks)")
    }
}
