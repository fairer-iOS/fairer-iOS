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
}

