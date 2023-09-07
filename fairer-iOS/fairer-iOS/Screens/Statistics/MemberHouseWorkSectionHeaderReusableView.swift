//
//  MemberHouseWorkSectionHeaderReusableView.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/09/01.
//

import UIKit

final class MemberHouseWorkSectionHeaderReusableView: UICollectionReusableView {
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이번달 집안일 현황을 확인해보세요."
        label.textColor = .gray800
        label.textAlignment = .left
        label.font = .title1
        return label
    }()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 가사 수행 16회"
        label.textColor = .gray600
        label.textAlignment = .left
        label.font = .title2
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
        self.addSubviews(titleLabel, subTitleLabel, divider)
    }
    
    private func render() {
        
        divider.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
        
}
