//
//  RankCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/08/30.
//

import UIKit

final class RankCollectionViewCell: BaseCollectionViewCell {
    
    private let firstRankerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.isHidden = true
        view.layer.cornerRadius = 4
        return view
    }()
    private let secondRankerView: UIView = {
        let view = UIView()
        view.backgroundColor = .positive10
        view.isHidden = true
        view.layer.cornerRadius = 4
        return view
    }()
    private let thirdRankerView: UIView = {
        let view = UIView()
        view.backgroundColor = .positive0
        view.isHidden = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    private var memberView = StatisticsMemberView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
    }
    
    override func setHierarchy() {
        self.addSubviews(memberView, firstRankerView, secondRankerView, thirdRankerView)
        
        self.bringSubviewToFront(memberView)
    }
    
    override func render() {
        memberView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(41)
            make.leading.trailing.equalToSuperview().inset(13).priority(.low)
            make.bottom.equalToSuperview().inset(14)
            make.centerX.equalToSuperview()
        }
        
        firstRankerView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        secondRankerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        
        thirdRankerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
}

extension RankCollectionViewCell {
    func setRankerViewisHidden(first: Bool, second: Bool, third: Bool) {
        firstRankerView.isHidden = first
        secondRankerView.isHidden = second
        thirdRankerView.isHidden = third
    }
    
    func setMemberRankTypeUI(_ memberRankType: MemberRankType) {
        self.memberView.setMemberRankTypeUI(memberRankType)
    }
}
