//
//  String+Extension.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import Foundation

extension String {
    var stringToDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.date(from: self)
    }
    
    var stringToDay: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.date(from: self)
    }
    
    func subStringToDate() -> String {
        let startIdx: String.Index = self.index(self.startIndex, offsetBy: 2)
        return String(self[startIdx...])
    }
    
    func hasCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern:"^[0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]*$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        }
        catch {
            return false
        }
        return false
    }
    
    func hasSpecialCharacters() -> Bool {
        if let regex = try? NSRegularExpression(pattern: "[0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣\\s]", options: .caseInsensitive) {
            let numOfString = regex.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.count))
            if numOfString == self.count {
                return false
            } else {
                return true
            }
        }
        return false
    }
    
    func twentyFourToTwelve() -> String {
        let time = self.split(separator: ":")
        if var hour = Int(time[0]), let minute = Int(time[1]) {
            if hour > 1 && hour < 12 {
                return "오전\n\(hour)시 \(minute)분"
            } else if hour == 12 {
                return "오후\n12시 \(minute)분"
            } else if hour == 0 {
                return "오전\n12시 \(minute)분"
            } else {
                hour = hour - 12
                return "오후\n\(hour)시 \(minute)분"
            }
        }
        return ""
    }
    
    func dayOfWeekToAPIString() -> String {
        switch self {
        case "0월":
            return "MONDAY"
        case "1화":
            return "TUESDAY"
        case "2수":
            return "WEDNESDAY"
        case "3목":
            return "THURSDAY"
        case "4금":
            return "FRIDAY"
        case "5토":
            return "SATURDAY"
        case "6일":
            return "SUNDAY"
        default:
            return ""
        }
    }
    
    func englishToDayOfWeekString() -> String {
        switch self {
        case "MONDAY":
            return "0월"
        case "TUESDAY":
            return "1화"
        case "WEDNESDAY":
            return "2수"
        case "THURSDAY":
            return "3목"
        case "FRIDAY":
            return "4금"
        case "SATURDAY":
            return "5토"
        case "SUNDAY":
            return "6일"
        default:
            return ""
        }
    }
}

