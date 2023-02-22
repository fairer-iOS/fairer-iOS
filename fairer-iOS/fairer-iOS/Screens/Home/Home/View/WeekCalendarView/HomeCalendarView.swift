//
//  HomeCalendarView.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/21.
//

import UIKit

import SnapKit

final class HomeCalendarView: BaseUIView {
    
    private var year = Date().yearToString
    private var month = Date().monthToString
    
    
    // MARK: - property
    
    lazy var calendarMonthLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("\(self.year)년 \(self.month)월", for: .normal)
        button.setTitleColor(.gray800, for: .normal)
        button.titleLabel?.font = .title2
        return button
    }()
    let calendarMonthPickButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.moveToCalendarButton, for: .normal)
        return button
    }()
    private lazy var calendarPicker: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calendarMonthLabelButton,calendarMonthPickButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    let todayButton: UIButton = {
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
        self.addSubviews(calendarPicker,todayButton)
        
        calendarPicker.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
            $0.width.equalTo(105)
        }
        
        calendarMonthPickButton.snp.makeConstraints {
            $0.height.width.equalTo(20)
        }
        
        todayButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
            // FIXME: - 좋은 방법은 아닌 것 같음
            $0.width.equalTo(37)
            $0.centerY.equalTo(calendarPicker.snp.centerY)
        }
    }
}
