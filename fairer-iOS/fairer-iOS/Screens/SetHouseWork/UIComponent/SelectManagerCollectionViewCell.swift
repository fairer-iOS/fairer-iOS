//
//  SelectManagerCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/22.
//

import UIKit

import SnapKit

final class SelectManagerCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    let profileImage = UIImageView(image: ImageLiterals.profileLightBlue1)
    let profileName: UILabel = {
        let label = UILabel()
        label.textColor = .gray800
        label.font = .body1
        return label
    }()
    private let selectIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.deselectManager
        imageView.tintColor = .gray200
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20, weight: .light))
        imageView.preferredSymbolConfiguration = config
        return imageView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
            $0.width.height.equalTo(24)
        }
        
        self.addSubview(profileName)
        profileName.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).offset(6)
        }
        
        self.addSubview(selectIcon)
        selectIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(20)
        }
    }
    
    override func configUI() {
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray200.cgColor
    }
}
