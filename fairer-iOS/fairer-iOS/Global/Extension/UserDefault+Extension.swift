//
//  UserDefault+Extension.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import Foundation

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
