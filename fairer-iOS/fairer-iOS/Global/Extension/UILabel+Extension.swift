//
//  UILabel+Extension.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

extension UILabel {
    func applyColor(to targetString: String, with color: UIColor) {
        if let labelText = self.text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.foregroundColor,
                                       value: color,
                                       range: (labelText as NSString).range(of: targetString))
            attributedText = attributedString
        }
    }
}
