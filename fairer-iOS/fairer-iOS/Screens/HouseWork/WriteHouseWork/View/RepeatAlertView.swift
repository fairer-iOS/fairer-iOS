//
//  RepeatAlertView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/04/09.
//

import UIKit

import SnapKit

final class RepeatAlertView: BaseUIView {
    
    // MARK: - property
    
    private let blurView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.3
        return view
    }()
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "반복 일정 삭제"
        label.font = .h3
        label.textColor = .gray800
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(blurView)
        blurView.addSubview(backgroundView)
        backgroundView.addSubviews(titleLabel)
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.width.equalTo(312)
            $0.height.equalTo(336)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - func
}
