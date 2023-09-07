//
//  RankSectionHeaderReusableView.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/08/30.
//

import UIKit

final class RankSectionHeaderReusableView: UICollectionReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "이번달 김유나님이\n가장 많은 집안일을 완료했어요!", lineHeight: 22)
        label.textColor = .gray800
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .title1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        self.addSubviews(titleLabel)
    }
    
    private func render() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
