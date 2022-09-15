//
//  MainButton.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import UIKit
import SnapKit

final class MainButton: UIButton {
    private enum Size {
        static let spacing: CGFloat = 24.0
        static let height: CGFloat = 56.0
        static let width: CGFloat = UIScreen.main.bounds.size.width - Size.spacing * 2
    }
    
    // MARK: - property
    
    var title: String? {
        didSet { setupAttribute() }
    }
    
    var isDisabled: Bool = false {
        didSet { setupAttribute() }
    }
        
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
        self.snp.makeConstraints{
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
        }
    }
    
    private func configUI() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
        titleLabel?.font = .title1
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .disabled)
        setTitleColor(.gray800, for: .reserved)
    }
    
    private func setupAttribute() {
        if let title = title {
            setTitle(title, for: .normal)
        }
        
        isEnabled = !isDisabled
    }
}
