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
//        imgView.image = UIImage(named: "2dot.svg")
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
    
    
    // MARK: - life cycle
    
    override func render() {
        
        self.addSubviews(workDot,dayLabel,dateLabel)
        
        workDot.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(22)
            $0.bottom.equalTo(dateLabel.snp.top)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(24)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configUI() {
        // cell layer
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemBackground.cgColor
    }
    
    func cellSelectedEvent(){
        if self.layer.borderColor == UIColor.systemBackground.cgColor {
            self.layer.borderColor = UIColor.gray100.cgColor
            self.backgroundColor = UIColor.gray100
            self.dateLabel.textColor = UIColor.blue
            self.dayLabel.textColor = UIColor.blue
        }
    }
}
