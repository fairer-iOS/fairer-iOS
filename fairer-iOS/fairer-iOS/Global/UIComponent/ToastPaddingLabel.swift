//
//  ToastPaddingLabel.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/03/30.
//

import UIKit.UILabel

import SnapKit

final class ToastPaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 5, left: 21.0, bottom: 5, right: 21.0)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += padding.left + padding.right
        contentSize.height += padding.top + padding.bottom
        
        return contentSize
    }
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func render() {
        textColor = .white
        font = .title2
        numberOfLines = 0
        backgroundColor = .gray700
        textAlignment = .center
        layer.cornerRadius = 8
        clipsToBounds = true
        alpha = 0
    }
    
    
}
