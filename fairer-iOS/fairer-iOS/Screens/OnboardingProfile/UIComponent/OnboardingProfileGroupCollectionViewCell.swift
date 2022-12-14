//
//  OnboardingProfileGroupCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/19.
//

import UIKit

import SnapKit

final class OnboardingProfileGroupCollectionViewCell: BaseCollectionViewCell {
    override var isSelected: Bool {
        didSet {
            DispatchQueue.main.async {
                self.checkCircleView.isHidden = !self.isSelected
            }
        }
    }
    
    // MARK: - property
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.profileBlue3
        return imageView
    }()
    private let checkCircleView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        view.isHidden = true
        return view
    }()
    
    // MARK: - lifecycle
    
    override func render() {
        self.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.addSubview(checkCircleView)
        checkCircleView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        checkCircleView.layer.cornerRadius = self.frame.width / 2
    }
}
