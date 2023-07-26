//
//  AlarmResponse.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/07/03.
//

struct AlarmResponse: Codable {
    let memberId: Int?
    let notCompleteStatus: Bool?
    let scheduledTimeStatus: Bool?
}
