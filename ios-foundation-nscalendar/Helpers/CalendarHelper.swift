//
//  CalendarHelper.swift
//  ios-foundation-nscalendar
//
//  Created by Eiji Kushida on 2017/04/04.
//  Copyright © 2017年 Kushida　Eiji. All rights reserved.
//

import Foundation

final class CalendarHelper {
    
    private var calendar = Calendar.current
    
    init() {
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        calendar.locale = Locale(identifier: "ja")
    }

    /// タイムゾーンを設定する
    ///
    /// - Parameter timeZone: タイムゾーンの文字列
    func setTimeZone(timeZone: String) {
         calendar.timeZone = TimeZone(identifier: timeZone)!
    }
    
    /// ロケールを設定する
    ///
    /// - Parameter locale: ロケールの文字列
    func setlocale(locale: String) {
        calendar.locale = Locale(identifier: locale)
    }
    
    /// TimeZoneのIDを取得する
    func currentTimeZone() -> String {
        return calendar.timeZone.identifier
    }
    
    /// 年を取得する
    func dateYear(date: Date) -> Int {
        return calendar.component(.year, from: date)
    }
    
    /// 月を取得する
    func dateMonth(date: Date) -> Int {
        return calendar.component(.month, from: date)
    }
    
    /// 日を取得する
    func dateDay(date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    /// 時間を取得する
    func dateHour(date: Date) -> Int {
        return calendar.component(.hour, from: date)
    }
    
    /// 分を取得する
    func dateMinute(date: Date) -> Int {
        return calendar.component(.minute, from: date)
    }
    
    /// 秒を取得する
    func dateSecond(date: Date) -> Int {
        return calendar.component(.second, from: date)
    }
    
    /// 曜日を取得する
    func dateWeekDay(date: Date) -> Int {
        return calendar.component(.weekday, from: date)
    }
    
    /// 年月日、時分秒を取得する（まとめて設定できる）
    func dateSettings(date: Date) -> DateComponents {
        return calendar
            .dateComponents(Set<Calendar.Component>(
                [.year,.month,.day,.hour,.minute,.second]),
                                       from: date)
    }
    
    /// 日付の差を取得する
    func diffDate(srcDate: Date, distDate: Date) -> Int {
        return calendar.dateComponents([.day]
            , from: srcDate, to: distDate).day!
    }
    
    /// ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
    func renderMonthSymbols() -> [String]{
        return calendar.monthSymbols
    }
    
    /// ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
    func renderWeekdaySymbols() -> [String]{
        return calendar.weekdaySymbols
    }
    
    /// ["日", "月", "火", "水", "木", "金", "土"]
    func renderShortWeekdaySymbols() -> [String]{
        return calendar.shortWeekdaySymbols
    }
    
    /// 該当の日付に更新する
    func updateDate(date: Date) -> DateComponents {
        
        var compontent = dateSettings(date: date)
        compontent.year = 2016
        compontent.month = 10
        compontent.day = 3
        return compontent
    }
    
    /// 月の初日に更新する
    func updateFirstDate(date: Date) -> DateComponents {
        
        var compontent = dateSettings(date: date)
        compontent.day = 1
        return compontent
    }
    
    /// 日付を表示する
    func dateString(date: Date) -> String {
        
        let component = dateSettings(date: date)
        return "\(component.year!)/\(component.month!)/\(component.day!) \(component.hour!):\(component.minute!):\(component.second!)"
    }
    
    /// DateComponentsをDateに変換する
    func compontentToDate(compontent: DateComponents) -> Date{
        return calendar.date(from: compontent)!
    }
    
    /// 該当月は、何週間あるか？
    func weekOfMonth(date: Date) -> Int {
        
        let compontent = updateFirstDate(date: date)
        let firstDateOfMonth = compontentToDate(compontent: compontent)
        return calendar.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth)!.count
    }
    
    /// 月初の日付は？
    ///
    /// - Parameter date: 日付
    /// - Returns: 月初の日付
    func startOfMonthDay(date: Date) -> Date? {
        var comp: DateComponents = Calendar
            .current.dateComponents([.year, .month, .day, .hour],
                                    from:date)
        comp.day = 1
        comp.hour = 9
        return Calendar.current.date(from: comp)!
    }
    
    /// 月末の日付は？
    ///
    /// - Parameter date: 日付
    /// - Returns: 月末の日付
    func endOfMonthDay(date: Date) -> Date? {
    
        var comp: DateComponents = Calendar
            .current.dateComponents([.month, .month, .day, .hour],
                                    from: date)
        comp.month = 1
        comp.day = -1
        comp.hour = 9
        
        let startOfDay = startOfMonthDay(date: date)
        return Calendar.current.date(byAdding: comp, to: startOfDay!)
    }
    
    /// 該当月の最終日は何日か？
    func endOfMonth(date: Date) -> Int {
        return calendar.range(of: .day, in: .month, for: date)!.count
    }
    
    /// 経過時間（秒ごと）
    ///
    /// - Parameters:
    ///   - fromDate: 比較元時間
    ///   - toDate: 比較先時間
    /// - Returns: 経過時間（秒）
    func passTimeBySecond(fromDate: Date, toDate: Date) -> Int {
        
        let components = calendar.dateComponents([.second],
                                                 from: fromDate,
                                                 to: toDate)
        return components.second!
    }
    
    /// 経過時間（分ごと)
    ///
    /// - Parameters:
    ///   - fromDate: 比較元時間
    ///   - toDate: 比較先時間
    /// - Returns: 経過時間（分）
    func passTimeByMinitue(fromDate: Date, toDate: Date) -> Int {
        
        let components = calendar.dateComponents([.minute],
                                                 from: fromDate,
                                                 to: toDate)
        return components.minute!
    }

    /// 経過時間（日ごと)
    ///
    /// - Parameters:
    ///   - fromDate: 比較元時間
    ///   - toDate: 比較先時間
    /// - Returns: 経過時間（分）
    func passTimeByDay(fromDate: Date, toDate: Date) -> Int {
        
        let components = calendar.dateComponents([.day],
                                                 from: fromDate,
                                                 to: toDate)
        return components.day!
    }
    
    /// 年月日が一致するか？
    ///
    /// - Parameters:
    ///   - fromDate: 比較元時間
    ///   - toDate: 比較先時間
    /// - Returns: 結果
    func isSameDate(fromDate: Date, toDate: Date) -> Bool {
        return calendar.isDate(fromDate, inSameDayAs: toDate)
    }
    
    /// 年が一致するか？
    ///
    /// - Parameters:
    ///   - fromDate: 比較元時間
    ///   - toDate: 比較先時間
    /// - Returns: 結果
    func isSameYear(fromDate: Date, toDate: Date) -> Bool {
        return calendar
            .compare(fromDate, to: toDate, toGranularity: .year) == .orderedSame
    }

    /// 月が一致するか？
    ///
    /// - Parameters:
    ///   - fromDate: 比較元時間
    ///   - toDate: 比較先時間
    /// - Returns: 結果
    func isSameMonth(fromDate: Date, toDate: Date) -> Bool {
        return calendar
            .compare(fromDate, to: toDate, toGranularity: .month) == .orderedSame
    }

}
