//
//  InfoLabel.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/26.
//

import UIKit

import SnapKit

final class InfoLabelView: UIView {
    
    var text: String? {
        didSet { setupAttribute() }
    }
    var imageColor: UIColor? {
        didSet { setupAttribute() }
    }
    var textColor: UIColor? {
        didSet { setupAttribute() }
    }
    
    // MARK: - property
    
    private let infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .load(systemName: "info.circle.fill")
        imageView.frame = CGRect(x: 0, y: 0, width: 13, height: 13)
        return imageView
    }()
    private var infoText: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .body2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    // MARK: - init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
    }
    
    private func render() {
        self.addSubview(infoImage)
        infoImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        self.addSubview(infoText)
        infoText.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(infoImage.snp.trailing).offset(8)
        }
    }
    
    private func setupAttribute() {
        infoText.text = text
        infoImage.tintColor = imageColor
        infoText.textColor = textColor
    }
}
