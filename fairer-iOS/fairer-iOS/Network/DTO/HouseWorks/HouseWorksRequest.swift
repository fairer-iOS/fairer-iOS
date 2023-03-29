//
//  HouseWorksRequest.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/03/02.
//

import Foundation

struct HouseWorksRequest: Codable {
    var assignees: [Int]
    var houseWorkName: String
    var repeatCycle: RepeatCycleType.RawValue = RepeatCycleType.once.rawValue
    var repeatPattern: String = Date().dateToAPIString
    var scheduledDate: String = Date().dateToAPIString
    var scheduledTime: String = String()
    var space: String
}

enum RepeatCycleType: String, CaseIterable {
    case once = "O"
    case daily = "D"
    case week = "W"
    case month = "M"
    
    var repeatLabel: String {
        switch self {
        case .once:
            return "하루"
        case .daily:
            return "매일"
        case .week:
            return "매주"
        case .month:
            return "매달"
        }
    }
}
