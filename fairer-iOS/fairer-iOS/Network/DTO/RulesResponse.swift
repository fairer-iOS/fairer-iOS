//
//  RulesResponse.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/03/05.
//

import Foundation

struct RulesResponse: Codable {
    let ruleResponseDtos: [ruleData]
    let teamId: Int
}

struct ruleData: Codable {
    let ruleId: Int
    let ruleName: String
}
