//
//  PresetsAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class PresetsAPI {
    
    private var presetsProvider = MoyaProvider<PresetRouter>(plugins: [MoyaLoggerPlugin()])
    
    init() { }
}
