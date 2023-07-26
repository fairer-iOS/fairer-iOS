//
//  BackButton.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/04.
//

import UIKit

import SnapKit

final class BackButton: UIButton {
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setBackButtonAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    private func configUI() {
        self.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        self.setImage(ImageLiterals.navigationBarBackButton, for: .normal)
        self.tintColor = UIColor(hex: "#323232")
    }
    
    private func setBackButtonAction() {
        self.popViewController()
    }
}
