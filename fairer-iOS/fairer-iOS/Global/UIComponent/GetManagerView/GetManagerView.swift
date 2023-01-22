//
//  GetManagerView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/22.
//

import UIKit

import SnapKit

final class GetManagerView: BaseUIView {
    
    // MARK: - property
    
    private let managerLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "담당자", lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private let getManagerCollectionView = GetManagerCollectionView()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(managerLabel)
        managerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        self.addSubview(getManagerCollectionView)
        getManagerCollectionView.snp.makeConstraints {
            $0.top.equalTo(managerLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.trailing.equalToSuperview().inset(72)
            $0.height.equalTo(86)
        }
    }
    
    // MARK: - func
}
