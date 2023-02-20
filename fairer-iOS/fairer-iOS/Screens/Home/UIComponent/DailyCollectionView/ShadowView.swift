//
//  ShadowView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/20.
//

import UIKit

class ShadowView: UIView {

    var setupShadowDone: Bool = false
    
    public func setupShadow() {
        if setupShadowDone { return }
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize()
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.04
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        print("setupShadow")
        setupShadowDone = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
}
