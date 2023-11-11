//
//  FeedbackCapsuleCollectionViewEmojiCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/09/19.
//

import UIKit

final class FeedbackCapsuleCollectionViewEmojiCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let emojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.emojiAngry
        return imageView
    }()
    private let emojiCountLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .gray800
        label.font = .caption1
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
        self.addSubviews(emojiImageView, emojiCountLabel)
        
        emojiImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        emojiCountLabel.snp.makeConstraints {
            $0.leading.equalTo(emojiImageView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
    }
}
