//
//  EmojiCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/08/30.
//

import UIKit

import SnapKit

final class EmojiCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray200
        view.layer.cornerRadius = 8
        return view
    }()
    private let emojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.emojiBlue
        return imageView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubviews(backView, emojiImageView)
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emojiImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(3)
        }
    }
}
