//
//  EmojiCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/08/30.
//

import UIKit

import SnapKit

final class EmojiCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            backView.backgroundColor = isSelected ? .clear : .gray200
        }
    }
    
    // MARK: - property
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        return view
    }()
    let emojiImageView = UIImageView()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(backView)
        backView.addSubview(emojiImageView)
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emojiImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(3)
        }
    }
}
