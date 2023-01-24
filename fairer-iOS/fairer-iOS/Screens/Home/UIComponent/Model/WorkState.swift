//
//  WorkState.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/23.
//

import UIKit

enum WorkState: CaseIterable {
    case finished
    case notFinished
    case overdue
    
    var cellColor: UIColor {
        switch self {
        case .finished :
            return UIColor.positive10
        case .notFinished :
            return UIColor.white
        case .overdue :
            return UIColor.negative0
        }
    }
}
