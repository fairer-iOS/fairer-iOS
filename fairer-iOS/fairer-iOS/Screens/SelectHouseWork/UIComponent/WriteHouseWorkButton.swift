//
//  WriteHouseWorkButton.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/02.
//

import UIKit

import SnapKit

final class WriteHouseWorkButton: UIButton {
    
    // MARK: - property
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.text = "집안일 직접 입력하기"
        label.textColor = .black
        label.font = .body1
        return label
    }()
    private let buttonChevron: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.writeHouseWorkChevron
        imageView.tintColor = .positive20
        return imageView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(buttonLabel)
        buttonLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(buttonChevron)
        buttonChevron.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(10)
            $0.height.equalTo(18)
        }
    }
    
    private func configUI() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.positive20.cgColor
        self.layer.cornerRadius = 6
    }
}
