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
            return ImageLiterals.imgKitchen //FIXME
        }
    }
}

