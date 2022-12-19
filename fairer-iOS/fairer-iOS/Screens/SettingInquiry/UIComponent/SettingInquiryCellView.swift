//
//  SettingInquiryCellView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/20.
//

import UIKit

final class SettingInquiryCellView: UIView {
    
    // MARK: - property
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트임"
        label.textColor = .gray800
        label.font = .body2
        return label
    }()
    private let cellButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = .caption1
        let action = UIAction { [weak self] _ in
            print("테스트 잘됨")
        }
        button.addAction(action, for: .touchUpInside)
    }()
    private let cellDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
}
