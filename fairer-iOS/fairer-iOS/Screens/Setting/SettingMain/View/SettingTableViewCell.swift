//
//  SettingTableViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/01.
//

import UIKit

import SnapKit

final class SettingTableViewCell: BaseTableViewCell {
    
    static let cellId = "CellId"
    
    // MARK: - property
    
    let cellImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .gray800
        return image
    }()
    let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray800
        label.font = .body2
        return label
    }()
    private let cellChevron: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.settingChevron
        return image
    }()
    private let cellDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(cellImage)
        cellImage.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        self.addSubview(cellLabel)
        cellLabel.snp.makeConstraints {
            $0.leading.equalTo(cellImage.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            
        }
        
        self.addSubview(cellChevron)
        cellChevron.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        self.addSubview(cellDivider)
        cellDivider.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
}
