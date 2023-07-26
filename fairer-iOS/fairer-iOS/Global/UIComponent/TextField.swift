//
//  TextField.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/04.
//

import UIKit

import SnapKit

final class TextField: UITextField {
    
    enum TextFieldType {
        case large
        case medium
        case small
        
        var textFieldHeight: CGFloat {
            switch self {
            case .large, .medium:
                return 58
            case .small:
                return 42
            }
        }
        
        var font: UIFont {
            switch self {
            case .large:
                return .h3
            case .medium, .small:
                return .body1
            }
        }
        
        var leftPadding: CGFloat {
            switch self {
            case .large, .medium:
                return 24
            case .small:
                return 16
            }
        }
    }
    
    // MARK: - property
    
    var type: TextFieldType
    var placeHolder: String
        
    // MARK: - init
    
    init(type: TextFieldType, placeHolder: String) {
        self.type = type
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.snp.makeConstraints {
            $0.height.equalTo(type.textFieldHeight)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .normal0
        self.font = type.font
        self.textColor = .gray800
        self.layer.cornerRadius = 8
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: type.leftPadding, height: type.textFieldHeight))
        self.leftViewMode = .always
        self.setClearButton()
        let attributes = [
            NSAttributedString.Key.font: type.font,
            NSAttributedString.Key.foregroundColor: UIColor.gray400
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: attributes)
    }
}
