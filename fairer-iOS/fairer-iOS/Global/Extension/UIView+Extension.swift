//
//  UIView+Extenstion.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/13.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}

