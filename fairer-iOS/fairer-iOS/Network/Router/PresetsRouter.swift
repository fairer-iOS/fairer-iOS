//
//  PresetRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum PresetRouter {
    case getAllPreset
}

extension PresetRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getAllPreset:
            return URLConstant.presets
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllPreset:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAllPreset:
            return .requestPlain
        }
    }
}
