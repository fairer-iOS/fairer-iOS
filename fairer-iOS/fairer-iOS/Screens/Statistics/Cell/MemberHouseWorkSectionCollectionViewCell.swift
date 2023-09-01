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
        button.setImage(ImageLiterals.moveToCalendarButton, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.layer.borderColor = UIColor.positive10.cgColor
        self.layer.borderWidth = 0.8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
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
            make.bottom.equalToSuperview().inset(16)
        }
        
        automaticSizebutton.snp.makeConstraints { make in
            make.centerY.equalTo(houseWorkCountLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
            make.height.equalTo(houseWorkCountLabel.snp.height)
            make.width.equalTo(20)
        }
        
        automaticSizebutton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
}
