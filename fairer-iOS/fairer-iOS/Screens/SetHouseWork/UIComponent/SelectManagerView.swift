//
//  SelectManagerView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/22.
//

import UIKit

import SnapKit

final class SelectManagerView: BaseUIView {
    
    // MARK: - property
    
    private let selectManagerLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "집안일 담당자 선택", lineHeight: 22)
        label.textColor = .gray800
        label.font = .title1
        return label
    }()
    private let selectManagerCollectionView = SelectManagerCollectionView()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(selectManagerLabel)
        selectManagerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(selectManagerCollectionView)
        selectManagerCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectManagerLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(142)
        }
    }
    
    override func configUI() {
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        self.layer.shadowOpacity = 0.03
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: -6)
    }
    
    // MARK: - func
}
