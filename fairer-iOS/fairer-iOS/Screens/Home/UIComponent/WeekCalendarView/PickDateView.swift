//
//  PickDateView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/11.
//

import UIKit

import SnapKit

final class PickDateView: BaseUIView {
    
    // MARK: - property
    
    var changeClosure: ((Date)->())?
    var dismissClosure: ((Date,Date,String,String)->())?
    private lazy var changeDateResult = Date()
    private lazy var changeDateStartDateWeekResult = Date()
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .inline
        return view
    }()
    let blurredEffectView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.6
        return view
    }()
    
    let pickerHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    // MARK: - life cycle

    override func render() {
        
        self.addSubviews(blurredEffectView, pickerHolderView)
        pickerHolderView.addSubview(datePicker)
        
        blurredEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pickerHolderView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.componentPadding)
            $0.centerY.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(SizeLiteral.componentPadding)
        }
    }
    
    // MARK: - func
    
    func setAction() {
        let dateDidChange = UIAction { [weak self] _ in
            self?.didChangeDate(self!.datePicker)
        }
        self.datePicker.addAction(dateDidChange, for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        blurredEffectView.addGestureRecognizer(tap)
    }
    
    // MARK: - @objc

    @objc func tapHandler(_ g: UITapGestureRecognizer) -> Void {
        self.changeDateResult = self.datePicker.date
        self.changeDateStartDateWeekResult = self.datePicker.date.startOfWeek
        dismissClosure?(self.changeDateResult, self.changeDateStartDateWeekResult,self.datePicker.date.yearToString
                        ,self.datePicker.date.monthToString)
    }
    
    func didChangeDate(_ sender: UIDatePicker) -> Void {
        changeClosure?(sender.date)
    }
}
