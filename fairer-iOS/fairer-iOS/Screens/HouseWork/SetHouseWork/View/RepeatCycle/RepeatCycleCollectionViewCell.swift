//
//  RepeatCycleCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/27.
//

import UIKit

import SnapKit

final class RepeatCycleCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setSelectedCellLayer()
            } else {
                setShadowCellLayer()
            }
        }
    }
    
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
    
    // MARK: - func
    
    private func setSelectedCellLayer() {
        self.backgroundColor = .positive10
        self.layer.borderColor = UIColor.blue.cgColor
        self.weekOfDayLabel.textColor = .blue
    }
    
    private func setShadowCellLayer() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.gray200.cgColor
        self.weekOfDayLabel.textColor = .gray600
    }
}
