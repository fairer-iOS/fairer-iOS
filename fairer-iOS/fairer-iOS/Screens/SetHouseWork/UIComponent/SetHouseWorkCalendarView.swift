//
//  SetHouseWorkCalendarView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/19.
//

import UIKit

import SnapKit

final class SetHouseWorkCalendarView: BaseUIView {
    var today = Date()
    
    // MARK: - property
    
    private lazy var calendarPicker: UIDatePicker = {
        let picker = UIDatePicker()
        let action = UIAction { [weak self] _ in
            self?.today = picker.date
        }
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko_KR")
        picker.preferredDatePickerStyle = .compact
        picker.subviews[0].subviews[0].subviews[0].alpha = 0
        picker.addAction(action, for: .valueChanged)
        return picker
    }()
    private let chevron: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.moveToCalendarButton
        image.tintColor = .gray800
        return image
    }()
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
        self.addSubview(calendarPicker)
        calendarPicker.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(8)
            $0.width.equalTo(120)
        }
        
        self.addSubview(chevron)
        chevron.snp.makeConstraints {
            $0.leading.equalTo(calendarPicker.snp.trailing).offset(-10)
            $0.centerY.equalTo(calendarPicker.snp.centerY)
            $0.width.height.equalTo(20)
        }
        
        self.addSubview(spaceLabel)
        spaceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.centerY.equalTo(calendarPicker.snp.centerY)
        }
        
        self.addSubview(spacePin)
        spacePin.snp.makeConstraints {
            $0.trailing.equalTo(spaceLabel.snp.leading).inset(-4)
            $0.centerY.equalTo(spaceLabel.snp.centerY)
        }
    }
}
