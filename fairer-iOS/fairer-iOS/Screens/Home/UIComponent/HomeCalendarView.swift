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
    
    // dummy
    var year = "2022"
    var month = "5"
    
    
    // MARK: - property
    
    // 캘린더를 띄울 버튼의 좌측 텍스트 부분
    private lazy var calendarMonthLabelButton : UIButton = {
        let button = UIButton()
        button.setTitle("\(self.year)년 \(self.month)월", for: .normal)
        button.setTitleColor(.gray800, for: .normal)
        button.titleLabel?.font = UIFont.font(AppFontName.semiBold, ofSize: 14)
        return button
    }()
    
    // 캘린더를 띄울 버튼의 우측 버튼 부분
    private lazy var calendarMonthPickButton : UIButton = {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
        button.setImage(UIImage(named: "keyboard_arrow_down.svg"), for: .normal)
        return button
    }()
    
    // 년,월을 보여주고 해당 월의 주간 캘린더를 설정하는 버튼
    private lazy var calendarPicker : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calendarMonthLabelButton,calendarMonthPickButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
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
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
            $0.width.equalTo(100)
        }
        
        self.addSubview(todayButton)
        todayButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
            // FIXME: - 좋은 방법은 아닌 것 같음
            $0.width.equalTo(37)
            $0.centerY.equalTo(calendarPicker.snp.centerY)
        }
    }
}
