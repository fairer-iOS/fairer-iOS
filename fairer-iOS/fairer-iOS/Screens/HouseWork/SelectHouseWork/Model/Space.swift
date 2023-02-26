//
//  Space.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/28.
//

import UIKit

enum Space: String, CaseIterable {
    case entrance = "현관"
    case livingRoom = "거실"
    case bathroom = "화장실"
    case outside = "외부"
    case room = "방"
    case kitchen = "부엌"
        
    var apiName: String {
        switch self {
        case .entrance:
            return "ENTRANCE"
        case .livingRoom:
            return "LIVINGROOM"
        case .bathroom:
            return "BATHROOM"
        case .outside:
            return "OUTSIDE"
        case .room:
            return "ROOM"
        case .kitchen:
            return "KITCHEN"
        }
    }
    
    var normalImage: UIImage {
        switch self {
        case .entrance:
            return ImageLiterals.imgEntrance
        case .livingRoom:
            return ImageLiterals.imgLivingRoom
        case .bathroom:
            return ImageLiterals.imgBathroom
        case .outside:
            return ImageLiterals.imgOutside
        case .room:
            return ImageLiterals.imgRoom
        case .kitchen:
            return ImageLiterals.imgKitchen
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .entrance:
            return ImageLiterals.imgSelectedEntrance
        case .livingRoom:
            return ImageLiterals.imgSelectedLivingRoom
        case .bathroom:
            return ImageLiterals.imgSelectedBathroom
        case .outside:
            return ImageLiterals.imgSelectedOutside
        case .room:
            return ImageLiterals.imgSelectedRoom
        case .kitchen:
            return ImageLiterals.imgSelectedKitchen
        }
    }
    
    var houseWorkDetailList: [String] {
        switch self {
        case .entrance:
            return ["현관 청소", "분리수거하기", "신발 정리"]
        case .livingRoom:
            return ["창 청소", "거실 청소", "물건 정리정돈", "환기 시키기", "빨래 돌리기", "빨래 개기", "세탁기 청소"]
        case .bathroom:
            return ["화장실 청소", "욕실 용품 정리", "변기 청소", "욕조 청소"]
        case .outside:
            return ["쓰레기 버리기", "장보기", "반려동물 산책", "마중 나가기"]
        case .room:
            return ["이불 정리", "물건 정리정돈", "화장대 정리", "방 청소", "옷장 정리"]
        case .kitchen:
            return ["설거지", "가스렌지 닦기", "냉장고 정리", "부엌 정리정돈", "음식물 쓰레기\n버리기", "식사 준비하기", "간식 준비하기"]
        }
    }
    
    var houseWorkDetailSize: CGFloat {
        switch self {
        case .entrance:
            return SizeLiteral.houseWorkDetailOneLineHeight
        case .livingRoom:
            return SizeLiteral.houseWorkDetailThreeLineHeight
        case .bathroom:
            return SizeLiteral.houseWorkDetailTwoLineHeight
        case .outside:
            return SizeLiteral.houseWorkDetailTwoLineHeight
        case .room:
            return SizeLiteral.houseWorkDetailTwoLineHeight
        case .kitchen:
            return SizeLiteral.houseWorkDetailThreeLineHeight
        }
    }
}

