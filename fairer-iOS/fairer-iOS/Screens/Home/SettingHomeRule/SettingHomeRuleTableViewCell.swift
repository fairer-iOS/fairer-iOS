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
    let clearButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.textFieldClearButton, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return button
    }()
    
    // MARK: - life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 24, bottom: 0, right: 24))
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
            $0.leading.equalTo(ruleLabel.snp.trailing).offset(12)
            $0.top.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    override func configUI() {
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .positive0
    }
}
