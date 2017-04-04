//
//  CalendarHelper.swift
//  ios-foundation-nscalendar
//
//  Created by Eiji Kushida on 2017/04/04.
//  Copyright © 2017年 Kushida　Eiji. All rights reserved.
//

import Foundation

final class CalendarHelper {
    
    private var timeZone = "Asia/Tokyo"
    private var local = "ja"
    private var calendar = NSCalendar.current

    func setTimeZone(timeZone: String) {
        self.timeZone = timeZone        
        calendar.timeZone = TimeZone(identifier: self.timeZone)!
    }
    
    func setLocal(local: String) {
        self.local = local
        calendar.locale = Locale(identifier: self.local)
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
            .dateComponents(Set<Calendar.Component>([.year,.month,.day,.hour,.minute,.second]),
                                       from: date)
    }
    
    /// 日付の差を取得する
    func diffDate(srcDate: Date, distDate: Date) -> Int {
        return calendar.dateComponents([.day], from: srcDate, to: distDate).day!
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
    func renderDate(date: Date) -> String {
        
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
    
    /// 該当月の最終日は何日か？
    func endOfMonth(date: Date) -> Int {
        return calendar.range(of: .day, in: .month, for: date)!.count
    }
}
