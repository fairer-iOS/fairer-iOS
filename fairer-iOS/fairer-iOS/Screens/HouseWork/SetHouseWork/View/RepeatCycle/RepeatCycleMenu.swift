//
//  RepeatCycleMenu.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/27.
//

import UIKit

import SnapKit

final class RepeatCycleMenu: BaseUIView {
    
    var didTappedRepeatCycleMenuButton: ((RepeatCycleType) -> ())?
    
    // MARK: - property
    
    private lazy var everyWeekButton: UIButton = {
        let button = UIButton()
        button.setTitle(RepeatType.week.rawValue, for: .normal)
        button.setTitleColor(.gray600, for: .normal)
        button.titleLabel?.font = .body2
        let action = UIAction { [weak self] _ in
            self?.didTappedRepeatCycleMenuButton?(.week)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private lazy var everyMonthButton: UIButton = {
        let button = UIButton()
        button.setTitle(RepeatType.month.rawValue, for: .normal)
        button.setTitleColor(.gray600, for: .normal)
        button.titleLabel?.font = .body2
        let action = UIAction { [weak self] _ in
            self?.didTappedRepeatCycleMenuButton?(.month)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubviews(everyWeekButton, divider, everyMonthButton)
        
        everyWeekButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().inset(16)
        }
        
        divider.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        everyMonthButton.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
        }
    }
    
    override func configUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.isHidden = true
    }
}
