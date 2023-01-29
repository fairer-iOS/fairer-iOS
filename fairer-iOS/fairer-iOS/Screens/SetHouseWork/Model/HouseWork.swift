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
    var time: String
    let space: String
    var manager: [String]
    var repeatCycle: String?
    var repeatPattern: [String]?
    
    #if DEBUG
    static var mockHouseWork: [HouseWork] = [
        HouseWork(name: "창 청소", date: Date(), time: "하루 종일", space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "거실 청소", date: Date(), time: "하루 종일", space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "물건 정리정돈", date: Date(), time: "하루 종일", space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "환기 시키기", date: Date(), time: "하루 종일", space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "빨래 돌리기", date: Date(), time: "하루 종일", space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "빨래 개기", date: Date(), time: "하루 종일", space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil),
        HouseWork(name: "세탁기 청소", date: Date(), time: "하루 종일", space: "거실", manager: ["고가혜"], repeatCycle: nil, repeatPattern: nil)
    ]
    #endif
}
