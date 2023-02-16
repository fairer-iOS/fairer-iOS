//
//  SetHouseWorkCalendarView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/19.
//

import UIKit

import SnapKit

final class CalendarSpaceView: BaseUIView {
    var today = Date()
    
    // MARK: - property
    
    private let pickDateButton = PickDateButton()
    private let spaceLabel: UILabel = {
        let label = UILabel()
        label.text = Space.livingRoom.rawValue
        label.textColor = .black
        label.font = .title1
        return label
    }()
    private let spacePin: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.spacePin
        return imageView
    }()
    
    
    // MARK: - life cycle
    
    override func configUI() {
        self.backgroundColor = .white
    }
    
    override func render() {
        self.addSubviews(pickDateButton, spaceLabel, spacePin)
        
        pickDateButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        spaceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.centerY.equalTo(pickDateButton.snp.centerY)
        }
        
        spacePin.snp.makeConstraints {
            $0.trailing.equalTo(spaceLabel.snp.leading).inset(-4)
            $0.centerY.equalTo(spaceLabel.snp.centerY)
        }
    }
}
