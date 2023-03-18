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
    var repeatCycle: RepeatCycleType.RawValue = "O"
    var repeatPattern: String?
    var scheduledDate: String
    var scheduledTime: String = "하루 종일"
    var space: String
}

enum RepeatCycleType: String {
    case once = "O"
    case daily = "D"
    case week = "W"
    case month = "M"
}
