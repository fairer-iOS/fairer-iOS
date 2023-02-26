//
//  GetPresetResponse.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/02/26.
//

import Foundation

struct GetPresetResponse: Codable {
    let houseworks: [String]
    let space: String
}
