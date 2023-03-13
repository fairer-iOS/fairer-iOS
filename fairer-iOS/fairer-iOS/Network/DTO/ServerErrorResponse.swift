//
//  ServerErrorResponse.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/03/13.
//

import Foundation

public struct ServerErrorResponse: Decodable {
    let code: Int
    let errorMessage: String
    let referrerUrl: String
}

