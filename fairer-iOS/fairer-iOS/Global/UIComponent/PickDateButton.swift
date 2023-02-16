//
//  PickDateButton.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/02/16.
//

import UIKit

import SnapKit

final class PickDateButton: UIButton {
    
    // MARK: - property
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = Date().dateToKoreanString
        label.textColor = .gray800
        label.font = .title1
        return label
    }()
    private let dateChevron: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.calendarChevron
        imageView.tintColor = .gray800
        return imageView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubviews(dateLabel, dateChevron)
        
        dateLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dateChevron.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.width.height.equalTo(20)
        }
    }
}
