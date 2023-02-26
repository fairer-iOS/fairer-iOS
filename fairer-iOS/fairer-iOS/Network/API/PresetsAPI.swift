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
    
    private(set) var getAllPresetData: [GetAllPresetResponse]?
    
    func getAllPresetData(completion: @escaping ([GetAllPresetResponse]?) -> Void){
        self.presetsProvider.request(.getAllPreset) { [self] (result) in
            switch result {
            case .success(let response):
                do {
                    self.getAllPresetData = try response.map([GetAllPresetResponse]?.self)
                    completion(getAllPresetData)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
