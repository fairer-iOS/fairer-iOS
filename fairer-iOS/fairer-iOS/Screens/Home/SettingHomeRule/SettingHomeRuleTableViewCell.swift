//
//  SettingHomeRuleTableViewCell.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/07.
//

import UIKit

import SnapKit

class SettingHomeRuleTableViewCell: BaseTableViewCell {
    
    static let cellId = "CellId"
    
    // MARK: - property
    
    let ruleLabel: UILabel = {
        let label = UILabel()
        label.font = .title2
        label.textColor = .gray600
        label.textAlignment = .left
        return label
    }()
    private let clearButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.textFieldClearButton, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return button
    }()
    
    // MARK: - life cycle
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    override func render() {
        contentView.addSubviews(ruleLabel, clearButton)
        
        ruleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(11)
            $0.bottom.equalToSuperview().inset(11)
        }
        
        clearButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
//            $0.leading.equalTo(ruleLabel.snp.trailing).offset(12)
            $0.top.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    override func configUI() {
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .positive0
    }
}
