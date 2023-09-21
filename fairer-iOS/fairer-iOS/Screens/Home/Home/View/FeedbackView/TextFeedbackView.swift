//
//  TextFeedbackView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/09/21.
//

import UIKit

final class TextFeedbackView: BaseUIView {
    
    // MARK: - property
    
    private let textfield: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .normal0
        textField.textColor = .gray800
        textField.font = .body1
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray200.cgColor
        textField.layer.cornerRadius = 8
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        textField.leftViewMode = .always
        let attributes = [
            NSAttributedString.Key.font: UIFont.body1,
            NSAttributedString.Key.foregroundColor: UIColor.gray400
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "피드백을 입력하세요", attributes: attributes)
        return textField
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(textfield)
        
        textfield.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(42)
        }
    }
    
    override func configUI() {
        self.backgroundColor = .normal0
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.layer.cornerRadius = 10
    }
}
