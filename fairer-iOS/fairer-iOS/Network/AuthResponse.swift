//
//  AuthResponse.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/28.
//

struct AuthResponse: Codable {
    let accessToken, accessTokenExpireTime: String
    let hasTeam, isNewMember: Bool
    let memberID: Int
    let memberName, refreshToken, refreshTokenExpireTime: String

    enum CodingKeys: String, CodingKey {
        case accessToken, accessTokenExpireTime, hasTeam, isNewMember
        case memberID = "memberId"
        case memberName, refreshToken, refreshTokenExpireTime
    }
}
