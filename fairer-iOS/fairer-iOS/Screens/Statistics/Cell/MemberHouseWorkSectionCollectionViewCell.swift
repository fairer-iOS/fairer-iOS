//
//  MemberHouseWorkSectionCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/08/30.
//

import UIKit

final class MemberHouseWorkSectionCollectionViewCell: BaseCollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "바닥 청소"
        label.textColor = .gray800
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .title1
        return label
    }()
    private let houseWorkCountLabel: UILabel = {
        let label = UILabel()
        label.text = "총 12회 완료"
        label.textColor = .gray800
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .caption1
        return label
    }()
    private let automaticSizebutton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray400
        button.setImage(ImageLiterals.moveToCalendarButton, for: .normal)
        return button
    }()
        
    override func layoutSubviews() {
        layer.shadowRadius = 8
    }
    
    override func configUI() {
        backgroundColor = .white
        layer.borderColor = UIColor.positive10.cgColor
        layer.borderWidth = 1
        layer.shadowOpacity = 0.04
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    override func setHierarchy() {
        [titleLabel, houseWorkCountLabel, automaticSizebutton].forEach { view in
            self.addSubview(view)
        }
    }
    
    override func render() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16).priority(.high)
            make.height.equalTo(22)
        }
        
        houseWorkCountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16).priority(.high)
        }
        
        automaticSizebutton.snp.makeConstraints { make in
            make.centerY.equalTo(houseWorkCountLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
            make.height.equalTo(houseWorkCountLabel.snp.height)
            make.width.equalTo(20)
        }
        
        automaticSizebutton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        automaticSizebutton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
}
