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
    var repeatCycle: String
    var repeatPattern: String?
    var scheduledDate: String
    var scheduledTime: String?
    var space: String
}
