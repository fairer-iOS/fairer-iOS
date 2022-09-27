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
    let spaceArray = ["현관", "거실", "화장실", "외부", "방", "부엌"]
    //FIXME: 이미지 없던거 추가할것
    let selectedSpaceArray = ["현관택", "거실택", "화장실택", "외부택", "방택", "방택"]
    
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
                spaceImageView.image = UIImage(named: "\(selectedSpaceArray[index])")
            }
            else {
                spaceImageView.image = UIImage(named: "\(spaceArray[index])")
            }
        }
    }
}
