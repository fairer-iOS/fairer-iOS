//
//  WriteHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/02/01.
//

import UIKit

import SnapKit

final class WriteHouseWorkViewController: BaseViewController {
    
    var houseWorkMaxLength = 16
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    // FIXME: - PR 머지되면 Calendar View Global 로
    private let writeHouseWorkCalendarView = SetHouseWorkCalendarView()
    private let houseWorkNameLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "집안일 이름", lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private let houseWorkNameTextField: TextField = {
        let textField = TextField()
        textField.type = .small
        textField.myPlaceholder = "직접 입력"
        return textField
    }()
    private let houseWorkNameWarningLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "텍스트는 16글자를 초과하여 입력하실 수 없어요.", lineHeight: 22)
        label.textColor = .negative20
        label.font = .body2
        return label
    }()
    
    // MARK: - life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotificationCenter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
    }
    
    override func render() {
        view.addSubviews(writeHouseWorkCalendarView, houseWorkNameLabel, houseWorkNameTextField, houseWorkNameWarningLabel)
        
        writeHouseWorkCalendarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(38)
        }
        
        houseWorkNameLabel.snp.makeConstraints {
            $0.top.equalTo(writeHouseWorkCalendarView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        houseWorkNameTextField.snp.makeConstraints {
            $0.top.equalTo(houseWorkNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(42)
        }
        
        houseWorkNameWarningLabel.snp.makeConstraints {
            $0.top.equalTo(houseWorkNameTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(0)
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupDelegation() {
        houseWorkNameTextField.delegate = self
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                // FIXME: - button 이동 로직 추가
            })
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // FIXME: - button 이동 로직 추가
        })
    }
    
    private func checkMaxLength() {
        if let text = houseWorkNameTextField.text {
            if text.count > houseWorkMaxLength {
                houseWorkNameTextField.layer.borderWidth = 1
                houseWorkNameTextField.layer.borderColor = UIColor.negative20.cgColor
                houseWorkNameWarningLabel.snp.updateConstraints {
                    $0.height.equalTo(22)
                }
            } else {
                houseWorkNameTextField.layer.borderWidth = 0
                houseWorkNameWarningLabel.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
            }
        }
    }
}

// MARK: - extension

extension WriteHouseWorkViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkMaxLength()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
