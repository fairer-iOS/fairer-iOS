//
//  NSObject+Extension.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

