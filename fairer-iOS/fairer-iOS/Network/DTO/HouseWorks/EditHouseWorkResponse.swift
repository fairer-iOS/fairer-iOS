//
//  EditHouseWorkResponse.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/04/05.
//

import Foundation

struct EditHouseWorkResponse: Codable {
    var houseWorkId: Int
    var space: String
    var houseWorkName: String
    var assignees: [MemberResponse]
    var scheduledDate: String
    var scheduledTime: String
    var success: Bool
    var repeatCycle: String
    var repeatPattern: String
    var repeatEndDate: String
}
