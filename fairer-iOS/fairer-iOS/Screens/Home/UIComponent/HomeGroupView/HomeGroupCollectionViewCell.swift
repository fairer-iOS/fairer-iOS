//
//  HomeGroupCollectionViewCell.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class HomeGroupCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.titleImage.image = ImageLiterals.profilelightblue1Selected
            }else {
                self.titleImage.image = ImageLiterals.profileLightBlue1
            }
        }
    }
    
    // MARK: - property
    
    let titleImage: UIImageView = {
        let imageView = UIImageView()
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
        self.addSubviews(titleImage,titleLabel)
        
        titleImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func onSelected(){
        self.titleImage.image = ImageLiterals.profilelightblue1Selected
    }
    
    func onDeselected(){
        self.titleImage.image = ImageLiterals.profileLightBlue1
    }
}
