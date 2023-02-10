//
//  MyDatePicker.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/09.
//

import SwiftUI

import SnapKit

final class MyDatePicker: UIView {
    
    var changeClosure: ((Date)->())?
    var dismissClosure: ((Date)->())?
    private lazy var changeDateResult = Date()
    private lazy var dPicker: UIDatePicker = {
        let v = UIDatePicker()
        v.datePickerMode = .dateAndTime
        return v
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() -> Void {

        let blurredEffectView : UIView = {
            let v = UIView()
            v.backgroundColor = UIColor.black
            v.alpha = 0.6
            return v
        }()
        
        let pickerHolderView: UIView = {
            let v = UIView()
            v.backgroundColor = .white
            v.layer.cornerRadius = 8
            return v
        }()
        
        [blurredEffectView, pickerHolderView, dPicker].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }

        addSubview(blurredEffectView)
        pickerHolderView.addSubview(dPicker)
        addSubview(pickerHolderView)

        blurredEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        pickerHolderView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(SizeLiteral.componentPadding)
            $0.trailing.equalToSuperview().inset(SizeLiteral.componentPadding)
            $0.centerY.equalToSuperview()
        }
        dPicker.snp.makeConstraints{
            $0.top.equalTo(pickerHolderView.snp.top).offset(10)
            $0.leading.equalTo(pickerHolderView.snp.leading).offset(SizeLiteral.componentPadding)
            $0.trailing.equalTo(pickerHolderView.snp.trailing).inset(SizeLiteral.componentPadding)
            $0.bottom.equalTo(pickerHolderView.snp.bottom).inset(SizeLiteral.componentPadding)
        }
        
        if #available(iOS 14.0, *) {
            dPicker.preferredDatePickerStyle = .inline
        } else {
            // use default
        }
        dPicker.addTarget(self, action: #selector(didChangeDate(_:)), for: .valueChanged)
        
        let t = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        blurredEffectView.addGestureRecognizer(t)
    }
    
    // MARK: - @objc

    @objc func tapHandler(_ g: UITapGestureRecognizer) -> Void {
        self.changeDateResult = self.dPicker.date.startOfWeek
        dismissClosure?(self.changeDateResult)
    }
    
    @objc func didChangeDate(_ sender: UIDatePicker) -> Void {
        changeClosure?(sender.date)
    }
}
