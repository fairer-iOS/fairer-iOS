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
    
    // MARK: - life cycle
    
    override func render() {
        
        self.addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
        
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
