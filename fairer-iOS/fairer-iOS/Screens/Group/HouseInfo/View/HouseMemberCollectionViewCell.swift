//
//  HouseMemberCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/31.
//

import UIKit

import SnapKit

final class HouseMemberCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let profileName: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .gray600
        return label
    }()
    
    // MARK: - lifecycle
    
    override func render() {
        self.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.width.height.equalTo(56)
        }

        self.addSubview(profileName)
        profileName.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom)
            $0.centerX.equalTo(profileImage.snp.centerX)
        }
    }
}
