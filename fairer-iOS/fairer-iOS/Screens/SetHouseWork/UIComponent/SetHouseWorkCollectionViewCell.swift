//
//  SetHouseWorkCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/19.
//

import UIKit

import SnapKit

final class SetHouseWorkCollectionViewCell: BaseCollectionViewCell {
    
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
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.setHouseWorkCollectionViewCellDefaultTimeLabel, lineHeight: 18)
        label.textColor = .gray700
        label.font = .caption1
        label.numberOfLines = 0
        return label
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(ImageLiterals.deleteButton, for: .normal)
        button.tintColor = .gray700
        return button
    }()
    let houseWorkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray600
        label.font = .title2
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(12)
        }
        
        self.addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(16)
        }
        
        self.addSubview(houseWorkLabel)
        houseWorkLabel.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(12)
        }
    }
    
    override func configUI() {
        self.layer.cornerRadius = 6
        self.backgroundColor = .normal0
    }
    
    // MARK: - func
    
    private func setSelectedCellLayer() {
        self.backgroundColor = .white
        self.layer.borderWidth = 1.06
        self.layer.borderColor = UIColor.blue.cgColor
        self.houseWorkLabel.textColor = .gray800
    }
    
    private func setShadowCellLayer() {
        self.backgroundColor = .normal0
        self.layer.borderWidth = 0
        self.houseWorkLabel.textColor = .gray600
    }
}
