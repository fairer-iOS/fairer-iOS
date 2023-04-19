//
//  AuthResponse.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/28.
//

struct AuthResponse: Codable {
    let accessToken: String?
    let accessTokenExpireTime: String?
    let hasTeam: Bool?
    let isNewMember: Bool?
    let memberId: Int?
    let memberName: String?
    let refreshToken: String?
    let refreshTokenExpireTime: String?
}
