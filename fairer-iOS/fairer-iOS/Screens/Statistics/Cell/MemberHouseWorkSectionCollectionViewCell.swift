//
//  MemberHouseWorkSectionCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/08/30.
//

import UIKit

final class MemberHouseWorkSectionCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "바닥 청소"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .h2
        return label
    }()
    private let houseWorkCountLabel: UILabel = {
        let label = UILabel()
        label.text = "총 12회 완료"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .title2
        return label
    }()
    private let automaticSizebutton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    
}
