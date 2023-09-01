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
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.backgroundColor = .black
        return v
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
        label.font = .body1
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
        
        [memBerImageView, memberNameLabel, houseWorkCountLabel].forEach { view in
            self.addSubview(view)
        }
        
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
        case .second:
            memberNameLabel.textColor = .black
            houseWorkCountLabel.textColor = .black
        case .third:
            memberNameLabel.textColor = .black
            houseWorkCountLabel.textColor = .black
        case .none:
            memberNameLabel.textColor = .gray800
            houseWorkCountLabel.textColor = .gray600
        }
    }
}
