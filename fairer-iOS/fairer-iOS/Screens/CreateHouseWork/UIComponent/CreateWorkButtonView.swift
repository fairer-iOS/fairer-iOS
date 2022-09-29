//
//  CreateWorkButton.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/29.
//

import UIKit

import SnapKit

class CreateWorkButtonView: UIView {
    
    // MARK: - property
    
    private let buttonTextLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.createWorkButtonViewButtonLabel
        label.font = .body1
        return label
    }()
    private let buttonArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.buttonArrowButton
        imageView.tintColor = .positive20
        return imageView
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        self.addSubview(buttonTextLabel)
        buttonTextLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.leading.equalToSuperview().inset(16)
        }
        
        self.addSubview(buttonArrowImageView)
        buttonArrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(buttonTextLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
