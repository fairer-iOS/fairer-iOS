//
//  ErrorResponse.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/25.
//

struct ErrorResponse: Codable {
    let timeStamp: String
    let status: Int
    let error: String?
    let path: String?
}
