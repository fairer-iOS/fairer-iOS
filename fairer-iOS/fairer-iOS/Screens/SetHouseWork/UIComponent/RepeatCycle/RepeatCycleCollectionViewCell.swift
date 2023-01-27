//
//  RepeatCycleCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/27.
//

import UIKit

import SnapKit

final class RepeatCycleCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    let weekOfDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray600
        label.font = .body2
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(weekOfDayLabel)
        weekOfDayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func configUI() {
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray200.cgColor
        self.layer.cornerRadius = 6
    }
}
