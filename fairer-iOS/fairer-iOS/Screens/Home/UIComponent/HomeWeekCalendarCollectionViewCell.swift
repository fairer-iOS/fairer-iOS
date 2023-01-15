//
//  HomeWeekCalendarCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/13.
//

import UIKit

import SnapKit

final class HomeWeekCalendarCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    let workDot: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray400
        // 일단 시스템 폰트로 해둠
        label.font = UIFont.body1
        label.textAlignment = .center
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray400
        // 일단 시스템 폰트로 해둠
        label.font = UIFont.body1
        label.textAlignment = .center
        return label
    }()
    
    var globalView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBackground.cgColor
        return view
    }()
    
    
    // MARK: - life cycle
    
    override func render() {
        
        self.addSubviews(workDot,globalView)
        globalView.addSubviews(dayLabel,dateLabel)
        self.bringSubviewToFront(workDot)
        
        workDot.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(16)
            $0.bottom.equalTo(globalView.snp.top).offset(3)
        }
        
        globalView.snp.makeConstraints {
            
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview()
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
}
