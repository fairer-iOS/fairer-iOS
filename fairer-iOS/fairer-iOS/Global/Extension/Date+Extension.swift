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
}
