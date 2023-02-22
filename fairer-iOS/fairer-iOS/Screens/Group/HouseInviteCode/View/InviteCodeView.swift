//
//  InviteCodeView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/05.
//

import UIKit

import SnapKit

final class InviteCodeView: UIView {
    
    var code: String? {
        didSet { setupAttribute() }
    }
    
    // MARK: - property
    
    private let inviteCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .h3
        label.textColor = .gray800
        label.textAlignment = .center
        return label
    }()

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
        configUI()
    }
    
    private func render() {
        self.addSubview(inviteCodeLabel)
        inviteCodeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(58)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .normal0
        self.layer.cornerRadius = 8
    }
    
    private func setupAttribute() {
        inviteCodeLabel.text = code
    }
}
