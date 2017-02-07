# NSCalendar

## 概要
NSCalendarは、カレンダーの情報を提供するクラスです。

## 関連クラス
NSTimeZone、NSLocale、Date、DateFormatter、DateComponent

## 主要プロパティ

|プロパティ名|説明|サンプル|例|
|---|---|---|---|
|timeZone | TimeZoneを取得する | calendar.timeZone |Asia/Tokyo|
|locale | Localeを取得する | calendar.locale |ja|
|monthSymbols | 月の配列を取得する | calendar.monthSymbols |["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]|
|weekdaySymbols | 週の配列を取得する | calendar.monthSymbols |["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]|


## 主要メソッド
|メソッド名|説明|サンプル|
|---|---|---|
|component | 日付を返す | calendar.component(.day, from: date) |
|range | カレンダーの特定の範囲の情報を返す | calendar.range(of: .day, in: .month, for: date)!.count |
|dateComponents | タイムゾーンに合わせた日付を返す | calendar.dateComponents(Set\<Calendar.Component\>([.year,.month,.day]),from: date) |
| isDateInToday | 今日か? | calendar.isDateInToday(date) |
| isDateInTomorrow | 明日か? | calendar.isDateInTomorrow(date) |
| isDateInWeekend | 週末か? | calendar.isDateInWeekend(date) |
| isDateInYesterday | 昨日か? | calendar.isDateInYesterday(date) |
| isDate | 同日か? | calendar.isDate(date1, inSameDayAs: date2) |

## フレームワーク
Foundation.framework

## サポートOSバージョン
iOS8.0以上

## 開発環境
|category | Version| 
|---|---|
| Swift | 3.0.2 |
| XCode | 8.2 |
| iOS | 10.0〜 |

## 参考
https://developer.apple.com/reference/foundation/nscalendar
