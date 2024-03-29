//
//  HomeWeekCalendarCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/13.
//

import UIKit

import SnapKit

final class HomeWeekCalendarCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                globalView.backgroundColor = UIColor.gray100
                dateLabel.textColor = UIColor.blue
                dayLabel.textColor = UIColor.blue
                dayLabel.font = .title2
                dateLabel.font = .title2
            } else {
                globalView.backgroundColor = .systemBackground
                dateLabel.textColor = .gray400
                dayLabel.textColor = .gray400
                dayLabel.font = .body2
                dateLabel.font = .body2
            }
        }
    }
    
    // MARK: - property
    
    let workDot = UIImageView()
    let workBlueBadge: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 8
        view.isHidden = true
        return view
    }()
    let workLeftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.caption1
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray400
        label.font = UIFont.body2
        label.textAlignment = .center
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray400
        label.font = UIFont.body2
        label.textAlignment = .center
        return label
    }()
    let globalView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBackground.cgColor
        return view
    }()
    
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubviews(workDot,workBlueBadge,globalView)
        globalView.addSubviews(dayLabel,dateLabel)
        workBlueBadge.addSubview(workLeftLabel)
        self.bringSubviewToFront(workDot)
        self.bringSubviewToFront(workBlueBadge)
        
        globalView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview()
        }
        
        workDot.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(16)
            $0.top.equalToSuperview()
        }
        
        workBlueBadge.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(16)
            $0.top.equalToSuperview()
        }
        
        workLeftLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
            $0.bottom.equalTo(dateLabel.snp.top)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.globalView.backgroundColor = .systemBackground
        self.dateLabel.textColor = .gray400
        self.dayLabel.textColor = .gray400
        self.dayLabel.font = .body2
        self.dateLabel.font = .body2
        self.workDot.image = nil
        self.workDot.isHidden = false
        self.workLeftLabel.isHidden = true
        self.workBlueBadge.isHidden = true
    }
}
