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
    
    private(set) var getAllPresetData: [GetPresetResponse]?
    private(set) var getHouseWorkPresetData: GetPresetResponse?
    
    func getAllPreset(completion: @escaping ([GetPresetResponse]?) -> Void) {
        self.presetsProvider.request(.getAllPreset) { [self] result in
            switch result {
            case .success(let response):
                do {
                    self.getAllPresetData = try response.map([GetPresetResponse]?.self)
                    completion(getAllPresetData)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getHouseWorkPreset(space: String, completion: @escaping (GetPresetResponse?) -> Void) {
        self.presetsProvider.request(.getHouseWorkPreset(space: space)) { [self] result in
            switch result {
            case .success(let response):
                do {
                    self.getHouseWorkPresetData = try response.map(GetPresetResponse.self)
                    completion(getHouseWorkPresetData)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
