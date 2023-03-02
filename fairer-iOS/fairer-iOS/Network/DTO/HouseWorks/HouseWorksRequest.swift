//
//  HouseWorksRequest.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/03/02.
//

import Foundation

struct HouseWorksRequest: Codable {
    let assignees: [Int]
    let houseWorkName: String
    // FIXME: - cycle type 4가지로 변경 필요
    let repeatCycle: String
    let repeatPattern: String?
    let scheduledDate: String
    let scheduledTime: String?
    let space: String
}
