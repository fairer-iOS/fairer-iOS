//
//  SettingAlarmTableViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/19.
//

import UIKit

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
}
