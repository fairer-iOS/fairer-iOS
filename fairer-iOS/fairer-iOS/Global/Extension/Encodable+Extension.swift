//
//  Excodable+Extension.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
