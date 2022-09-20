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
    let spaceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .title2
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(spaceNameLabel)
        spaceNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
