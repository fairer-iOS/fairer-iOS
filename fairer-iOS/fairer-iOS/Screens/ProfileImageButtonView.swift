//
//  ProfileImageButtonView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/15.
//

import UIKit

import SnapKit

final class ProfileImageButtonView: UIButton {
    
    var image: UIImage = ImageLiterals.profileNone {
        didSet {
            setupAttribute()
        }
    }
    
    // MARK: - property
    
    private lazy var profileImageView = UIImageView()
    private let profileBrushImageView = UIImageView(image: ImageLiterals.settingProfileImageBrushButton)
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileImageView.addSubview(profileBrushImageView)
        profileBrushImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.bottom.equalTo(profileImageView.snp.bottom).offset(-8)
            $0.trailing.equalTo(profileImageView.snp.trailing).offset(-8)
        }
    }
    
    private func setupAttribute() {
        profileImageView.image = image
    }
}
