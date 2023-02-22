//
//  SettingAlarmTableViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/19.
//

import UIKit

import SnapKit

final class SettingAlarmViewCell: UIView {
    
    var labelText: String? {
        didSet { setupAttribute() }
    }
    
    // MARK: - property
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray800
        label.font = .body2
        return label
    }()
    private let cellToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .blue
        toggle.isOn = false
        toggle.transform = CGAffineTransform(scaleX: 0.9, y: 0.8)
        return toggle
    }()
    private let cellDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    func render() {
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
    
    // MARK: - func
    
    private func setupAttribute() {
        cellLabel.text = labelText
    }
}
