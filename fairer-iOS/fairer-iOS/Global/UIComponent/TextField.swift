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
        case small
        
        var textFieldHeight: CGFloat {
            switch self {
            case .large:
                return 58
            case .small:
                return 42
            }
        }
        
        var font: UIFont {
            switch self {
            case .large:
                return .h3
            case .small:
                return .body1
            }
        }
        
        var leftPadding: CGFloat {
            switch self {
            case .large:
                return 24
            case .small:
                return 16
            }
        }
    }
    
    // MARK: - property
    
    var type: TextFieldType? {
        didSet { configUI() }
    }
    
    var myPlaceholder: String? {
        didSet { setupAttribute() }
    }
        
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.snp.makeConstraints {
            $0.height.equalTo(type?.textFieldHeight ?? 58)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .normal0
        self.font = type?.font ?? .h3
        self.layer.cornerRadius = 8
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: type?.leftPadding ?? 24, height: type?.textFieldHeight ?? 58))
        self.leftViewMode = .always
        self.setClearButton()
    }
    
    private func setupAttribute() {
        let attributes = [
            NSAttributedString.Key.font: type?.font ?? UIFont.h3,
            NSAttributedString.Key.foregroundColor: UIColor.gray400
        ]
        self.attributedPlaceholder = NSAttributedString(string: myPlaceholder ?? "값을 입력하세요", attributes: attributes)
    }
}

