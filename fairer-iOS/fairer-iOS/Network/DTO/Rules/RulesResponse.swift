//
//  RulesResponse.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/03/05.
//

struct RulesResponse: Codable {
    let ruleResponseDtos: [RuleData]?
    let teamId: Int
}

struct RuleData: Codable {
    let ruleId: Int
    let ruleName: String
}
