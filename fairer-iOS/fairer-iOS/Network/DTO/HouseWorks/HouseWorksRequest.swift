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
    // FIXME: - cycle type 4가지로 변경 필요
    var repeatCycle: RepeatCycleType.RawValue
    var repeatPattern: String?
    var scheduledDate: String?
    var scheduledTime: String?
    var space: String
}

enum RepeatCycleType: String {
    case once = "O"
    case daily = "D"
    case week = "W"
    case month = "M"
}
