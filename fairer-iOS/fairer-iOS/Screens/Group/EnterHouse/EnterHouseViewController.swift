//
//  EnterHouseViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/15.
//

import UIKit

import SnapKit

final class EnterHouseViewController: BaseViewController {

    // MARK: - property
    
    private let backButton = BackButton()
    private let enterHousePrimaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.enterHouseViewControllerPrimaryLabel, lineHeight: 28)
        label.font = .h2
        label.textColor = .gray800
        return label
    }()
    private let enterHouseSecondaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.enterHouseViewControllerSecondaryLabel, lineHeight: 26)
        label.font = .body1
        label.textColor = .gray400
        return label
    }()
    private let enterHouseCodeTextfield = TextField(type: .large, placeHolder: TextLiteral.enterHouseViewControllerTextfieldPlaceHolder)
    private lazy var enterHouseDoneButton: MainButton = {
        let button = MainButton()
        button.isDisabled = true
        button.title = TextLiteral.doneButtonText
        let buttonAction = UIAction { [weak self] _ in
            self?.touchUpToShowToast()
        }
        button.addAction(buttonAction, for: .touchUpInside)
        return button
    }()

    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
        setupNotificationCenter()
    }
    
    override func render() {
        view.addSubview(enterHousePrimaryLabel)
        enterHousePrimaryLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(enterHouseSecondaryLabel)
        enterHouseSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(enterHousePrimaryLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(enterHouseCodeTextfield)
        enterHouseCodeTextfield.snp.makeConstraints {
            $0.top.equalTo(enterHouseSecondaryLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(enterHouseDoneButton)
        enterHouseDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - functions
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupDelegation() {
        enterHouseCodeTextfield.delegate = self
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.enterHouseDoneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 20)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.enterHouseDoneButton.transform = .identity
        })
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func touchUpToShowToast() {
        guard let inviteCode = enterHouseCodeTextfield.text else { return }
        postJoinTeam(inviteCode: inviteCode)
    }
    
    private func showToast(_ message: String) {
        let toastLabel = ToastPaddingLabel(text: message)
        
        view.addSubview(toastLabel)
        toastLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        UIView.animate(withDuration: 0.8, animations: {
            toastLabel.alpha = 1.0
        }, completion: { isCompleted in
            UIView.animate(withDuration: 2.2, animations: {
                toastLabel.alpha = 0
            }, completion: { isCompleted in
                toastLabel.removeFromSuperview()
            })
        })
        
    }
}

extension EnterHouseViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 12 else { return false }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let hasText = enterHouseCodeTextfield.hasText
        enterHouseDoneButton.isDisabled = !hasText
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension EnterHouseViewController {
    private func postJoinTeam(inviteCode: String) {
        NetworkService.shared.teams.postJoinTeam(inviteCode: inviteCode) { [weak self] result in
            switch result {
            case .success:
                    self?.navigationController?.pushViewController(HouseInfoViewController(), animated: true)
            case .requestErr(let error):
                guard let errorResponse = error as? UserErrorResponse else { return }
                self?.showToast(errorResponse.errorMessage)
            default:
                print("server Error")
            }
        }
    }
}

