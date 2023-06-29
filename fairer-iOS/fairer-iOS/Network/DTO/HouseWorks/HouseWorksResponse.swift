//
//  HouseWorksResponse.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/03/02.
//

import Foundation

typealias HouseWorksResponse = [HouseWorkResponse]

struct HouseWorkResponse: Codable {
    let assignees: [MemberResponse]
    let houseWorkCompleteId: Int
    let houseWorkId: Int
    let houseWorkName: String
    let repeatCycle: String
    let repeatEndDate: String
    let repeatPattern: String
    let scheduledDate: String
    let scheduledTime: String
    let space: String
    let success: Bool
    let successDateTime: String
}

struct HouseWorkIdResponse: Codable {
    let houseWorkId: Int
    let space: String
    let houseWorkName: String
    let assignees: [MemberResponse]
    let scheduledDate: String
    let success: Bool
    let repeatCycle: String
    let repeatPattern: String
}
