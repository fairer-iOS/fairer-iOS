//
//  OnboardingProfileGroupCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/19.
//

import UIKit

import SnapKit

final class OnboardingProfileGroupCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.profileBlue3
        return imageView
    }()
    
    // MARK: - lifecycle
    
    override func render() {
        self.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.top.bottom.width.height.equalToSuperview()
        }
    }
}
