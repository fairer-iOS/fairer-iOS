//
//  AddFeedbackView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/08/31.
//

import UIKit

final class AddFeedbackView: BaseUIView {
    
    var didTappedAddFeedbackButton: (() -> ())?
    
    // MARK: - property
    
    private let addFeedbackButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    private let addFeedbackLabel: UILabel = {
        let label = UILabel()
        label.text = "텍스트 피드백 작성"
        label.font = .body1
        label.textColor = .gray800
        return label
    }()
    private let addFeedbackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.pencil
        imageView.tintColor = .gray800
        return imageView
    }()
    private let emojiCollectionView = EmojiCollectionView()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
        setButtonAction()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func render() {
        self.addSubviews(emojiCollectionView, addFeedbackButton)
        addFeedbackButton.addSubviews(addFeedbackLabel, addFeedbackImage)
        
        emojiCollectionView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        addFeedbackButton.snp.makeConstraints {
            $0.bottom.equalTo(emojiCollectionView.snp.top).offset(-4)
            $0.height.equalTo(42)
            $0.leading.trailing.equalToSuperview()
        }
        
        addFeedbackLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        addFeedbackImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(20)
            $0.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func configUI() {
        self.layer.shadowOpacity = 0.24
        self.layer.shadowRadius = 18
    }
    
    // MARK: - func
    
    private func setButtonAction() {
        let addFeedbackAction = UIAction { [weak self] _ in
            self?.didTappedAddFeedbackButton?()
        }
        addFeedbackButton.addAction(addFeedbackAction, for: .touchUpInside)
    }
}
