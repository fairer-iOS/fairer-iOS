//
//  TextField.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/04.
//

import UIKit

import SnapKit

final class TextField: UITextField {
    
    // MARK: - property
    
    var myPlaceholder: String? {
        didSet { setupAttribute() }
    }
    
    let attributes = [
        NSAttributedString.Key.font: UIFont.h3,
        NSAttributedString.Key.foregroundColor: UIColor.gray400
    ]
        
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
        configUI()
    }
    
    private func render() {
        self.snp.makeConstraints {
            $0.height.equalTo(58)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .normal0
        self.font = .h3
        self.layer.cornerRadius = 8
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 58))
        self.leftViewMode = .always
        self.setClearButton()
    }
    
    private func setupAttribute() {
        self.attributedPlaceholder = NSAttributedString(string: myPlaceholder ?? "값을 입력하세요", attributes: attributes)
    }
}

