//
//  MemberCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/22.
//

import UIKit

import SnapKit

final class MemberCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let profileImage = UIImageView(image: ImageLiterals.profileLightBlue1)
    let profileLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray800
        label.font = .caption1
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        
        self.addSubview(profileLabel)
        profileLabel.snp.makeConstraints {
            $0.centerX.equalTo(profileImage)
            $0.top.equalTo(profileImage.snp.bottom).offset(4)
        }
    }
}
