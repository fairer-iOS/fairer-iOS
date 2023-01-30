//
//  RepeatCycleView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/26.
//

import UIKit

import SnapKit

enum RepeatType: String {
    case week = "매주"
    case month = "매달"
}

final class RepeatCycleView: BaseUIView {
    
    // MARK: - property
    
    let repeatCycleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.repeatCycleViewRepeatCycleLabel
        label.textColor = .gray600
        label.font = .title2
        label.isHidden = true
        return label
    }()
    let repeatCycleButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        return button
    }()
    let repeatCycleButtonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray300
        label.font = .title2
        return label
    }()
    private let repeatCycleButtonChevron: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.repeatCycleChevronButton
        return imageView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubviews(repeatCycleLabel, repeatCycleButton)
        repeatCycleButton.addSubviews(repeatCycleButtonLabel, repeatCycleButtonChevron)
        
        repeatCycleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        repeatCycleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        repeatCycleButtonLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        repeatCycleButtonChevron.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(repeatCycleButtonLabel.snp.trailing).offset(4)
        }
    }
    
    override func configUI() {
        self.backgroundColor = .normal0
        self.layer.cornerRadius = 4
    }
}
