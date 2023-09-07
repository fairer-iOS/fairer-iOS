//
//  StatisticsMemberView.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/09/01.
//

import UIKit

enum MemberRankType {
    case first
    case second
    case third
    case none
}

final class StatisticsMemberView: BaseUIView {

    private var memberRankType: MemberRankType = .none
    
    private var memBerImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .black
        return view
    }()
    
    
    private let memberNameLabel: UILabel = {
        let label = UILabel()
        label.text = "최지혜"
        label.textColor = .gray800
        label.textAlignment = .left
        label.font = .body2
        return label
    }()
    private let houseWorkCountLabel: UILabel = {
        let label = UILabel()
        label.text = "12회"
        label.textColor = .gray600
        label.textAlignment = .left
        label.font = .body2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setMemberRankTypeUI(memberRankType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(memberRankType: MemberRankType) {
        self.init()
        self.memberRankType = memberRankType
    }
    
    private func setHierarchy() {
    }
    
    override func render() {
        
        addSubviews(memBerImageView, memberNameLabel, houseWorkCountLabel)
        
        memBerImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.size.equalTo(48)
        }
        
        memberNameLabel.snp.makeConstraints { make in
            make.top.equalTo(memBerImageView.snp.bottom).offset(4)
            make.centerX.equalTo(memBerImageView.snp.centerX)
            make.height.equalTo(houseWorkCountLabel.snp.height)
        }
        
        houseWorkCountLabel.snp.makeConstraints { make in
            make.top.equalTo(memberNameLabel.snp.bottom).offset(2)
            make.centerX.equalTo(memBerImageView.snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
}

extension StatisticsMemberView {
    func setMemberRankTypeUI(_ memberRankType: MemberRankType) {
        switch memberRankType {
        case .first:
             memberNameLabel.textColor = .white
             houseWorkCountLabel.textColor = .white
             houseWorkCountLabel.font = .title2
         case .second:
             memberNameLabel.textColor = .gray800
             houseWorkCountLabel.textColor = .gray800
             houseWorkCountLabel.font = .title2
         case .third:
             memberNameLabel.textColor = .gray800
             houseWorkCountLabel.textColor = .gray800
             houseWorkCountLabel.font = .title2
         case .none:
             memberNameLabel.textColor = .gray800
             houseWorkCountLabel.textColor = .gray600
             houseWorkCountLabel.font = .body2
        }
    }
}
