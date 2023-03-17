//
//  SettingHomeRuleTableViewCell.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/07.
//

import UIKit

import SnapKit


final class SettingHomeRuleTableViewCell: BaseTableViewCell {
    
    static let cellId = "CellId"
    
    // MARK: - property
    
    let ruleLabel: UILabel = {
        let label = UILabel()
        label.font = .title1
        label.textColor = .gray600
        label.textAlignment = .left
        return label
    }()
    let clearButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.smallClearButton, for: .normal)
        return button
    }()
    
    // MARK: - life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 24, bottom: 16, right: 24))
    }
    
    override func render() {
        contentView.addSubviews(ruleLabel, clearButton)
        
        ruleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(11)
            $0.bottom.equalToSuperview().inset(11)
        }
        	
        clearButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
    }
    
    override func configUI() {
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .positive0
    }
}
