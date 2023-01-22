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
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(managerLabel)
        managerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - func
}
