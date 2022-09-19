//
//  UITextField+Extension.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/18.
//

import UIKit

extension UITextField {
    func setClearButton() {
        let button = UIButton()
        button.setImage(ImageLiterals.textFieldClearButton, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.addTarget(self, action: #selector(UITextField.clear), for: .touchUpInside)
        self.addTarget(self, action: #selector(UITextField.displayClearButton), for: .editingDidBegin)
        self.addTarget(self, action: #selector(UITextField.displayClearButton), for: .editingChanged)
        self.rightView = button
        self.rightViewMode = .whileEditing
    }
    
    @objc
    private func displayClearButton() {
        self.rightView?.isHidden = (self.text?.isEmpty) ?? true
    }
    
    @objc
    private func clear() {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}
