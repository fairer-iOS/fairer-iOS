//
//  TeamInfoResponse.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/03/02.
//

struct TeamInfoResponse: Codable {
    let members: [MemberResponse]?
    let teamId: Int?
    let teamName: String?
}
