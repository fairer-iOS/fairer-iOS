//
//  HouseWorksResponse.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/03/05.
//

import Foundation

typealias WorkInfoReponse = [String: DayHouseWorks]

struct DayHouseWorks: Codable {
    let memberId: Int
    let scheduledDate: String
    let countDone, countLeft: Int
    var houseWorks: [HouseWorkData]?
}

struct HouseWorkData: Codable {
    let houseWorkId: Int?
    let space, houseWorkName: String?
    let assignees: [Assignee]?
    let repeatCycle: String?
    let repeatEndDate: String?
    let repeatPattern: String?
    let scheduledDate: String?
    let scheduledTime: String?
    var success: Bool
    let successDateTime: String?
    let houseWorkCompleteId: Int?
}

struct Assignee: Codable {
    let memberId: Int?
    let memberName: String?
    let profilePath: String?
}