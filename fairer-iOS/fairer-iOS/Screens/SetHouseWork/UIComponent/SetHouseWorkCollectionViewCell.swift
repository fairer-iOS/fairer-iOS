//
//  SetHouseWorkCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/19.
//

import UIKit

import SnapKit

final class SetHouseWorkCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "하루 종일", lineHeight: 18)
        label.textColor = .gray700
        label.font = .caption1
        return label
    }()
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(ImageLiterals.deleteButton, for: .normal)
        button.tintColor = .gray700
        let action = UIAction { [weak self] _ in
            self?.didTappedDeleteButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    let houseWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "창 청소"
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
    
    private func didTappedDeleteButton() {
        print("Delete")
    }
}
