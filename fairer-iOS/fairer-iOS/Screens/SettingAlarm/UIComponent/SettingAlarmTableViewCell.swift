//
//  SettingAlarmTableViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/19.
//

import UIKit

import SnapKit

final class SettingAlarmTableViewCell: BaseTableViewCell {
    
    // MARK: - property
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.text = "예시"
        label.textColor = .gray800
        label.font = .body2
        return label
    }()
    private let cellToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .blue
        toggle.isOn = false
        return toggle
    }()
    private let cellDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(cellLabel)
        cellLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        self.addSubview(cellToggle)
        cellToggle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.addSubview(cellDivider)
        cellDivider.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
