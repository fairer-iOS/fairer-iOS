//
//  ImageLiteral.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import UIKit

enum ImageLiterals {
    
    // MARK: - image
    static var imgLogo: UIImage { .load(name: "fairerlogo") }
    
    // MARK: - button
    
    static var textFieldClearButton: UIImage { .load(name: "clearbutton")}
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
    
    static func load(systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = systemName
        return image
    }
}
