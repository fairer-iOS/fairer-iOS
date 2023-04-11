//
//  RepeatAlertTableViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/04/09.
//

import UIKit

import SnapKit

final class RepeatAlertTableViewCell: BaseTableViewCell {
    
    static let cellId = "cellId"
    
    // MARK: - property
    
    let label: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .gray600
        return label
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.repeatAlertDeSelectedButton, for: .normal)
        button.tintColor = .gray800
        return button
    }()
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubviews(label, button, divider)
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(1)
        }
    }
}
