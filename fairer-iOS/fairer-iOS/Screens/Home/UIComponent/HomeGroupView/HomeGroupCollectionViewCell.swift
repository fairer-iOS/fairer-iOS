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
    
    let titleImage = UIImageView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
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
            $0.top.equalTo(titleImage.snp.bottom).offset(4)
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
