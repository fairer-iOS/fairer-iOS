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
        view.backgroundColor = .black
        view.isHidden = true
        return view
    }()
    private let secondRankerView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.isHidden = true
        return view
    }()
    private let thirdRankerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        [firstRankerView, secondRankerView, thirdRankerView].forEach { view in
            self.addSubviews(view)
        }
    }
    
    override func render() {
        firstRankerView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        secondRankerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        
        thirdRankerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
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
}
