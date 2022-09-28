//
//  SelectHouseWorkSpaceCollectionViewCell.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/20.
//

import UIKit

import SnapKit

final class SelectHouseWorkSpaceCollectionViewCell: BaseCollectionViewCell {
    
    var index: Int = 0
    
    // MARK: - property
    let spaceImageView = UIImageView()
    lazy var spaceNameLabel: SpaceNameLabel = {
        let label = SpaceNameLabel()
        label.backgroundColor = .white
        label.font = .title2
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
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
    
    override func configUI() {
        spaceNameLabel.layer.cornerRadius = 12
    }
    
    // MARK: - function
    override var isSelected: Bool {
        didSet {
            if isSelected {
                spaceImageView.image = Space.allCases[index].selecteImage
            }
            else {
                spaceImageView.image = Space.allCases[index].normalImage
            }
        }
    }
}
