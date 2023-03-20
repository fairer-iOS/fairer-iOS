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
        // 오전 1~11 / 오후 13~23 / 오전 12시 0 / 오후 12시 24
        if var hour = Int(time[0]) {
            
        }
        if var hour = Int(time[0]), hour > 12 {
            hour = hour - 12
            return "오후\n\(hour)시 \(time[1])분"
        } else {
            return "오전\n\(time[0])시 \(time[1])분"
        }
    }
}

