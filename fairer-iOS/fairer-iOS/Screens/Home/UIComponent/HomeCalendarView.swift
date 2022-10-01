//
//  HomeCalendarView.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/21.
//

import UIKit

import SnapKit

final class HomeCalendarView: BaseUIView {
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
    private let todayButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.homeCalendarViewTodayTitle, for: .normal)
        button.setTitleColor(.positive20, for: .normal)
        button.titleLabel?.font = .caption1
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.positive20.cgColor
        return button
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        self.backgroundColor = .white
    }
    
    override func render() {
        self.addSubview(calendarPicker)
        calendarPicker.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalToSuperview().inset(8)
            $0.width.equalTo(100)
        }
        
        self.addSubview(todayButton)
        todayButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(20)
            // FIXME: - 좋은 방법은 아닌 것 같음
            $0.width.equalTo(37)
            $0.centerY.equalTo(calendarPicker.snp.centerY)
        }
    }
}
