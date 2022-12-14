//
//  HomeGroupCollectionViewCell.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class HomeGroupCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    let titleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "applelogo")
        imageView.tintColor = .black
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        // FIXME: - figma 디자인시스템 정리 후 수정되야함
        label.font = .font(.regular, ofSize: 12)
        label.textColor = .gray800
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(titleImage)
        titleImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
