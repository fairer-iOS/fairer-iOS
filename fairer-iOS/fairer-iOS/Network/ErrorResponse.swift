//
//  ErrorResponse.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/28.
//

struct ErrorResponse: Codable {
    let code: Int
    let errorMessage, referrerURL: String

    enum CodingKeys: String, CodingKey {
        case code, errorMessage
        case referrerURL = "referrerUrl"
    }
}
