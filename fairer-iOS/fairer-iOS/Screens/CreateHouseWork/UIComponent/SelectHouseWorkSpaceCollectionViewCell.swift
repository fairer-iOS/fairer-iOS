//
//  SelectHouseWorkSpaceCollectionViewCell.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/20.
//

import UIKit

import SnapKit

final class SelectHouseWorkSpaceCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    let spaceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.r
        return imageView
    }()
    let spaceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .title2
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(spaceImageView)
        spaceImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(spaceNameLabel)
        spaceNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}
