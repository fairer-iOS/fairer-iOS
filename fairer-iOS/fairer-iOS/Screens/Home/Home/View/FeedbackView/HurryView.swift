//
//  HurryView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/08/31.
//

import UIKit

final class HurryView: BaseUIView {
    
    var didTappedHurryButton: (() -> ())?
    
    // MARK: - property
    
    private let hurryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    private let hurryLabel: UILabel = {
        let label = UILabel()
        label.text = "재촉하기"
        label.font = .body1
        label.textColor = .gray800
        return label
    }()
    private let hurryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.hurry
        imageView.tintColor = .gray800
        return imageView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
        setButtonAction()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func render() {
        self.addSubviews(hurryButton)
        hurryButton.addSubviews(hurryLabel, hurryImage)
        
        hurryButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        hurryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        hurryImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(18)
            $0.height.equalTo(22)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func configUI() {
        self.layer.shadowOpacity = 0.24
        self.layer.shadowRadius = 18
    }
    
    // MARK: - func
    
    private func setButtonAction() {
        let hurryAction = UIAction { [weak self] _ in
            self?.didTappedHurryButton?()
        }
        hurryButton.addAction(hurryAction, for: .touchUpInside)
    }
}
