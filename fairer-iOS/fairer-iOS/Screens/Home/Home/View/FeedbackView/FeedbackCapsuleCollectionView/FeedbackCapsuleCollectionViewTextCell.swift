//
//  FeedbackCapsuleCollectionViewTextCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/09/18.
//

import UIKit

final class FeedbackCapsuleCollectionViewTextCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let feedbackLabel: UILabel = {
        let label = UILabel()
        label.text = "텍스트 피드백"
        label.textColor = .black
        label.font = .caption1
        return label
    }()
    private let feedbackCountLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.font = .caption1
        label.textColor = .gray800
        return label
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        self.backgroundColor = .gray100
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray200.cgColor
        self.layer.cornerRadius = 14
    }
    
    override func render() {
        self.addSubviews(feedbackLabel, feedbackCountLabel)
        
        feedbackLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        
        feedbackCountLabel.snp.makeConstraints {
            $0.leading.equalTo(feedbackLabel.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}
