//
//  CreateHouseWorkCalendarView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/02.
//

import UIKit

import SnapKit

final class CreateHouseWorkCalendarView: BaseUIView {
    var today = Date()
    
    // MARK: - property
    
    private lazy var calendarPicker: UIDatePicker = {
        let picker = UIDatePicker()
        let action = UIAction { [weak self] _ in
            self?.today = picker.date
            picker.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .clear
        }
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko_KR")
        picker.preferredDatePickerStyle = .compact
        picker.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .clear
        picker.addAction(action, for: .valueChanged)
        return picker
    }()
    private let chevron: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.calendarChevron
        image.tintColor = .gray800
        return image
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        self.backgroundColor = .white
    }
    
    override func render() {
        self.addSubview(calendarPicker)
        calendarPicker.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(chevron)
        chevron.snp.makeConstraints {
            $0.leading.equalTo(calendarPicker.snp.trailing).offset(-10)
            $0.centerY.equalTo(calendarPicker.snp.centerY)
            $0.width.height.equalTo(20)
        }
    }
}
