//
//  EditHouseWorkRequest.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/04/05.
//

import Foundation

struct EditHouseWorkRequest: Codable, Equatable {
    var assignees: [Int]?
    var houseWorkId: Int?
    var houseWorkName: String?
    var repeatCycle: String?
    var repeatEndDate: String?
    var repeatPattern: String?
    var scheduledDate: String?
    var scheduledTime: String?
    var space: String?
    var type: String?
    var updateStandardDate: String?
}
