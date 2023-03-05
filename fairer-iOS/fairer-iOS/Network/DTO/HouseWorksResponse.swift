//
//  HouseWorksResponse.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/03/05.
//

import Foundation

// MARK: - HouseWorksResponse
struct HouseWorksResponse: Codable {
    let additionalProp: WorkInfo?
}

// MARK: - WorkInfo
struct WorkInfo: Codable {
    let memberId: Int
    let scheduledDate: String
    let countDone, countLeft: Int
    let houseWorks: [HouseWorkData]?
}

// MARK: - HouseWork
struct HouseWorkData: Codable {
    let houseWorkId: Int
    let space, houseWorkName: String
    let repeatCycle: String
    let repeatEndDate: String
    let repeatPattern: String
    let assignees: [Assignee]
    let scheduledDate: String
    let success: Bool
    let successDateTime: String
    let houseWorkCompleteId: Int
    let scheduledTime: String?
}

// MARK: - Assignee
struct Assignee: Codable {
    let memberId: Int
    let memberName: String
    let profilePath: String
}
