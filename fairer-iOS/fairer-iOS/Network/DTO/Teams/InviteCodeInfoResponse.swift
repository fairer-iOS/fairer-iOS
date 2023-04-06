//
//  InviteCodeInfoResponse.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/04/06.
//

struct InviteCodeInfoResponse: Codable {
    let inviteCode: String
    let inviteCodeExpirationDateTime: String
    let teamName: Int
}
