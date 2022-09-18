//
//  UIFont+Extension.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import UIKit

enum AppFontName: String {
    case regular = "Pretendard-Regular"
    case bold = "Pretendard-Bold"
    case medium = "Pretendard-Medium"
    case semiBold = "Pretendard-SemiBold"
}

extension UIFont {
    static func font(_ style: AppFontName, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
    
    // MARK: - H
    static var h1: UIFont {
        return font(.bold, ofSize: 24)
    }
    static var h2: UIFont {
        return font(.semiBold, ofSize: 20)
    }
    static var h3: UIFont {
        return font(.medium, ofSize: 20)
    }
    
    // MARK: - Title
    static var title1: UIFont {
        return font(.semiBold, ofSize: 16)
    }
    static var title2: UIFont {
        return font(.semiBold, ofSize: 14)
    }
    
    // MARK: - Body
    static var body1: UIFont {
        return font(.regular, ofSize: 16)
    }
    static var body2: UIFont {
        return font(.regular, ofSize: 14)
    }
    
    // MARK: - Caption
    static var caption1: UIFont {
        return font(.regular, ofSize: 12)
    }
    static var caption2: UIFont {
        return font(.regular, ofSize: 10)
    }
}
