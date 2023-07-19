//
//  UserDefaults+Extension.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/07/17.
//

import Foundation

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
