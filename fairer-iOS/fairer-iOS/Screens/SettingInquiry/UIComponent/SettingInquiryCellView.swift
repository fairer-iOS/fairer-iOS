//
//  SettingInquiryCellView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/20.
//

import UIKit

import SnapKit
import SafariServices

enum InquiryType {
    case email
    case instagram
    
    var labelText: String {
        switch self {
        case .email:
            return "이메일"
        case .instagram:
            return "Instagram"
        }
    }
    
    var buttonText: String {
        switch self {
        case .email:
            return "faireran@gmail.com"
        case .instagram:
            return "@fairer.official"
        }
    }
}

final class SettingInquiryCellView: BaseUIView {
    
    var inquiryType: InquiryType? {
        didSet { setupAttribute() }
    }
    
    var didTappedMail: (() -> ())?
        
    // MARK: - property
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray800
        label.font = .body2
        return label
    }()
    private lazy var cellButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = .caption1
        let action = UIAction { [weak self] _ in
            self?.didTappedCellButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let cellDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(cellLabel)
        cellLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        self.addSubview(cellButton)
        cellButton.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
        
        self.addSubview(cellDivider)
        cellDivider.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - func
    
    private func didTappedCellButton() {
        switch inquiryType {
        case .email:
            didTappedMail?()
        case .instagram:
            guard let url = URL(string: "https://www.instagram.com/fairer.official/") else { return }
            guard UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        case .none:
            return print("어느것도 해당 안됨")
        }
    }
    
    private func setupAttribute() {
        cellLabel.text = inquiryType?.labelText
        cellButton.setTitle(inquiryType?.buttonText, for: .normal)
        cellButton.setUnderline()
    }
}
