//
//  Date+Extension.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import Foundation

extension Date {
    var dateToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
    
    var letterDateToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
    
    var dateToKoreanString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 H시 M분"
        return formatter.string(from: self)
    }
    
    var dayToKoreanString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter.string(from: self)
    }
    
    var yearToString: String {
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "yyyy"
        var current_year_string = formatter_year.string(from: Date())
        return current_year_string
    }
    
    var monthToString: String {
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "MM"
        var current_year_string = formatter_year.string(from: Date())
        return current_year_string
    }
    
    var startOfWeek: Date {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        let dslTimeOffset = NSTimeZone.local.daylightSavingTimeOffset(for: date)
        return date.addingTimeInterval(dslTimeOffset)
    }

    var endOfWeek: Date {
        return Calendar.current.date(byAdding: .second, value: 604799, to: self.startOfWeek)!
    }
    
    var timeToKoreanString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a\nh시 m분"
        return formatter.string(from: self)
    }
    
    var dayOfWeekToKoreanString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier:"ko_KR")
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
    
    var singleDayToKoreanString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier:"ko_KR")
        formatter.dateFormat = "d일"
        return formatter.string(from: self)
    }
}
