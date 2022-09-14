//
//  UIColor+Extension.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import UIKit

extension UIColor {
    
    // MARK: - Brand Color
    static var blueLight: UIColor {
        return UIColor(hex: "#00ECFF")
    }
    static var blue: UIColor {
        return UIColor(hex: "#0C6DFF")
    }
    static var blueDark: UIColor {
        return UIColor(hex: "#2100FF")
    }
    // MARK: - Positive
    static var positive0: UIColor {
        return UIColor(hex: "#F1F5FC")
    }
    static var positive10: UIColor {
        return UIColor(hex: "#E1EDFF")
    }
    static var positive20: UIColor {
        return UIColor(hex: "#74ABFD")
    }
    // MARK: - Normal
    static var normal0: UIColor {
        return UIColor(hex: "#F5F6F8")
    }
    // MARK: - Negative
    static var negative0: UIColor {
        return UIColor(hex: "#FFF8F9")
    }
    static var negative10: UIColor {
        return UIColor(hex: "#FFD2DD")
    }
    static var negative20: UIColor {
        return UIColor(hex: "#E93B65")
    }
    // MARK: - White
    static var white: UIColor {
        return UIColor(hex: "#00ECFF")
    }
    // MARK: - Gray
    static var gray100: UIColor {
        return UIColor(hex: "#F2F2F2")
    }
    static var gray200: UIColor {
        return UIColor(hex: "##D9D9D9")
    }
    static var gray300: UIColor {
        return UIColor(hex: "#B3B3B3")
    }
    static var gray400: UIColor {
        return UIColor(hex: "#999999")
    }
    static var gray500: UIColor {
        return UIColor(hex: "#808080")
    }
    static var gray600: UIColor {
        return UIColor(hex: "#666666")
    }
    static var gray700: UIColor {
        return UIColor(hex: "#4D4D4D")
    }
    static var gray800: UIColor {
        return UIColor(hex: "#333333")
    }
    static var black: UIColor {
        return UIColor(hex: "#1A1A1A")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
