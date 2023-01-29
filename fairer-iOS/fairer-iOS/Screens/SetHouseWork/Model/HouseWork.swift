//
//  HouseWork.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/29.
//

import UIKit

struct HouseWork {
    let name: String
    let date: Date
    let time: Date?
    let space: String
    let manager: [String]
    let repeatCycle: String?
    let repeatPattern: String?
    
    #if DEBUG
    static let mockHouseWork: [HouseWork] = [
        HouseWork(name: "창 청소", date: Date(), time: nil, space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "거실 청소", date: Date(), time: nil, space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "물건 정리정돈", date: Date(), time: nil, space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "환기 시키기", date: Date(), time: nil, space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "빨래 돌리기", date: Date(), time: nil, space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "빨래 개기", date: Date(), time: nil, space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "세탁기 청소", date: Date(), time: nil, space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil)
    ]
    #endif
}
