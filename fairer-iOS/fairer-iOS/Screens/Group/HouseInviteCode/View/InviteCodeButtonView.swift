//
//  InviteCodeButtonView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/08.
//

import UIKit

import SnapKit

final class InviteCodeButtonView: UIView {
    
    private enum Size {
        static let width: CGFloat = UIScreen.main.bounds.size.width - SizeLiteral.leadingTrailingPadding * 2
        static let height: CGFloat = 184.0
    }
    
    var code: String?
    
    // MARK: - property
    
    private lazy var copyCodeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = ImageLiterals.imgCopyCode
        config.imagePlacement = .leading
        config.baseForegroundColor = .blue
        var titleAttr = AttributedString.init(TextLiteral.houseInviteCodeViewControllerCopyCodeButtonText)
        titleAttr.font = .title1
        config.attributedTitle = titleAttr
        config.imagePadding = 4
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 8
        button.backgroundColor = .positive10
        let buttonAction = UIAction { [weak self] _ in
            self?.touchUpToShowToast()
        }
        button.addAction(buttonAction, for: .touchUpInside)
        return button
    }()
    private let kakaoShareButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = ImageLiterals.imgKakaoShare
        config.imagePlacement = .leading
        config.baseForegroundColor = UIColor(red: 0.141, green: 0.051, blue: 0.047, alpha: 1)
        var titleAttr = AttributedString.init(TextLiteral.houseInviteCodeViewControllerKakaoShareButtonText)
        titleAttr.font = .title1
        config.attributedTitle = titleAttr
        config.imagePadding = 4
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 0.992, green: 0.945, blue: 0.38, alpha: 1)
        return button
    }()
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.houseInviteCodeViewControllerSkipButtonText, for: .normal)
        button.titleLabel?.font = .title1
        button.setTitleColor(.gray800, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    convenience init(skipButtonisHidden: Bool) {
        self.init()
        skipButton.isHidden = skipButtonisHidden
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
    }
    
    private func render() {
        [copyCodeButton, kakaoShareButton, skipButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        copyCodeButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        self.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - function
    
    private func touchUpToShowToast() {
        UIPasteboard.general.string = code
        showToast()
    }
    
    private func showToast() {
        let toastLabel = UILabel()
        toastLabel.text = TextLiteral.houseInviteCodeViewControllerCopyCodeToastLabel
        toastLabel.textColor = .white
        toastLabel.font = .title2
        toastLabel.backgroundColor = .gray700
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds = true
        toastLabel.alpha = 0
        self.addSubview(toastLabel)
        toastLabel.snp.makeConstraints {
            $0.bottom.equalTo(skipButton.snp.bottom).inset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(36)
        }
        UIView.animate(withDuration: 1.0, animations: {
            toastLabel.alpha = 1.0
        }, completion: { isCompleted in
            UIView.animate(withDuration: 1.0, animations: {
                toastLabel.alpha = 0
            }, completion: { isCompleted in
                toastLabel.removeFromSuperview()
            })
        })
        
    }
}
