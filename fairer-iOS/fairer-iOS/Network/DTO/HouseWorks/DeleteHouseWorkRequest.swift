//
//  DeleteHouseWorkRequest.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/04/05.
//

import Foundation

struct DeleteHouseWorkRequest: Codable {
    var deleteStandardDate: String
    var houseWorkId: Int
    var type: String
}
