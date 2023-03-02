//
//  MemberResponse.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/03/02.
//

import Foundation

struct MemberResponse: Codable {
    let memberId: Int
    let memberName: String
    let profilePath: String
    let statusMessage: String?
}
