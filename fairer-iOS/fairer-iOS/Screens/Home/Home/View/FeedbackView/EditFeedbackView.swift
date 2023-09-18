//
//  EditFeedbackView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/08/31.
//

import UIKit

final class EditFeedbackView: BaseUIView {
    
    var didTappedEditFeedbackButton: (() -> ())?
    var didTappedDeleteFeedbackButton: (() -> ())?
    
    // MARK: - property
    
    private let feedbackBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    private let editFeedbackButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    private let editFeedbackLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackViewEditFeedbackLabel
        label.font = .body1
        label.textColor = .gray800
        return label
    }()
    private let editFeedbackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.pencil
        imageView.tintColor = .gray800
        return imageView
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private let deleteFeedbackButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    private let deleteFeedbackLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.feedbackViewDeleteFeedbackLabel
        label.font = .body1
        label.textColor = .negative20
        return label
    }()
    private let deleteFeedbackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.trash
        imageView.tintColor = .negative20
        return imageView
    }()
    let emojiCollectionView = EmojiCollectionView()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonAction()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func render() {
        self.addSubviews(emojiCollectionView, feedbackBackgroundView)
        feedbackBackgroundView.addSubviews(editFeedbackButton, dividerView, deleteFeedbackButton)
        editFeedbackButton.addSubviews(editFeedbackLabel, editFeedbackImage)
        deleteFeedbackButton.addSubviews(deleteFeedbackLabel, deleteFeedbackImage)
        
        emojiCollectionView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        feedbackBackgroundView.snp.makeConstraints {
            $0.bottom.equalTo(emojiCollectionView.snp.top).offset(-4)
            $0.height.equalTo(84)
            $0.width.equalTo(272)
        }
        
        editFeedbackButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(editFeedbackButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        deleteFeedbackButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        editFeedbackLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        editFeedbackImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(20)
            $0.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        deleteFeedbackLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        deleteFeedbackImage.snp.makeConstraints {
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
        let editFeedbackAction = UIAction { [weak self] _ in
            self?.didTappedEditFeedbackButton?()
        }
        editFeedbackButton.addAction(editFeedbackAction, for: .touchUpInside)
        
        let deleteFeedbackAction = UIAction { [weak self] _ in
            self?.didTappedDeleteFeedbackButton?()
        }
        deleteFeedbackButton.addAction(deleteFeedbackAction, for: .touchUpInside)
    }
}
