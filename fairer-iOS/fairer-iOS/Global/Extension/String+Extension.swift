//
//  String+Extension.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import UIKit

extension String {
    var stringToDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.date(from: self)
    }
    
    var apiStringToDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
    
    var stringToDay: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.date(from: self)
    }
    
    var stringToTime: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.date(from: self)
    }
    
    var iso8601ToDay: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.date(from: self)
    }
    
    var iso8601ToKoreanString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        dateFormatter.dateFormat = "yyyy년 M월 d일 H시 mm분"
        return dateFormatter.string(from: date)
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
    
    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
    
    func profileAssetStringToString(imageAssetString: String) -> String {
        switch imageAssetString {
        case "profileblue3": return TextLiteral.profileImageURL[0]
        case "profileblue4": return TextLiteral.profileImageURL[1]
        case "profilepink1": return TextLiteral.profileImageURL[2]
        case "profileorange1": return TextLiteral.profileImageURL[3]
        case "profilepink3": return TextLiteral.profileImageURL[4]
        case "profilepurple1": return TextLiteral.profileImageURL[5]
        case "profilepurple2": return TextLiteral.profileImageURL[6]
        case "profilepurple3": return TextLiteral.profileImageURL[7]
        case "profileorange2": return TextLiteral.profileImageURL[8]
        case "profileyellow2": return TextLiteral.profileImageURL[9]
        case "profileindigo3": return TextLiteral.profileImageURL[10]
        case "profilegreen1": return TextLiteral.profileImageURL[11]
        case "profileyellow1": return TextLiteral.profileImageURL[12]
        case "profilegreen3": return TextLiteral.profileImageURL[13]
        case "profilelightblue1": return TextLiteral.profileImageURL[14]
        case "profilelightblue2": return TextLiteral.profileImageURL[15]
        default: return String()
        }
    }
    
    func manageNicknameLength() -> String {
        if self.count >= 5 {
            var managedNickname = self
            managedNickname.removeSubrange(self.index(self.startIndex, offsetBy: 4)..<self.endIndex)
            managedNickname.append("..")
            return managedNickname
        } else {
            return self
        }
    }
    
    func apiDateToDatePicker() -> String {
        var apiDate = self.split(separator: "-")
        
        if apiDate[1].hasPrefix("0") {
            apiDate[1].removeFirst()
        }
        
        if apiDate[2].hasPrefix("0") {
            apiDate[2].removeFirst()
        }
        
        return apiDate[0] + "년 " + apiDate[1] + "월 " + apiDate[2] + "일"
    }
}

