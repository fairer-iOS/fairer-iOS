//
//  ChangeHouseNameViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/30.
//

import UIKit

final class ChangeHouseNameViewController: BaseViewController {
    
    private var isNameSatisfied = true
    private var lastName: String?
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let changeHouseNameTitleLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.changeHouseNameViewControllerTitleLabel, lineHeight: 28)
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    private let changeHouseNameSecondaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.changeHouseNameViewControllerSecondaryLabel, lineHeight: 26)
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private let houseNameTextField: TextField = {
        let textField = TextField(type: .large, placeHolder: TextLiteral.houseMakeNameViewControllerTextFieldPlaceholder)
        return textField
    }()
    private lazy var changeHouseNameDoneButton: MainButton = {
        let button = MainButton()
        button.isDisabled = true
        button.title = TextLiteral.changeHouseNameViewControllerDoneButtonText
        let action = UIAction { [weak self] _ in
            self?.didTapDoneButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let houseNameNumWarningLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.textFieldWarningOverTwenty
        label.textColor = .negative20
        label.font = .body2
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    private let houseNameSpecialWarningLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.textFieldDisableSignLabel
        label.textColor = .negative20
        label.font = .body2
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    private lazy var changeHouseNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [houseNameNumWarningLabel, houseNameSpecialWarningLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
        setupNotificationCenter()
        getTeamInfo()
    }
    
    override func render() {
        view.addSubview(changeHouseNameTitleLabel)
        changeHouseNameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(changeHouseNameSecondaryLabel)
        changeHouseNameSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(changeHouseNameTitleLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(houseNameTextField)
        houseNameTextField.snp.makeConstraints {
            $0.top.equalTo(changeHouseNameSecondaryLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(changeHouseNameStackView)
        changeHouseNameStackView.snp.makeConstraints {
            $0.top.equalTo(houseNameTextField.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(changeHouseNameDoneButton)
        changeHouseNameDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
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
        houseNameTextField.delegate = self
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.changeHouseNameDoneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 35)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.changeHouseNameDoneButton.transform = .identity
        })
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func didTapDoneButton() {
        guard let text = houseNameTextField.text else { return }
        patchTeamInfo(teamName: text)
    }
    
    private func checkDoneButton() {
        changeHouseNameDoneButton.isDisabled = !isNameSatisfied || lastName == houseNameTextField.text
    }
    
    private func checkTextField() {
        if let text = houseNameTextField.text {
            if text.count > 16 || text.hasSpecialCharacters() {
                houseNameTextField.layer.borderWidth = 1
                houseNameTextField.layer.borderColor = UIColor.negative20.cgColor
                isNameSatisfied = false
            } else {
                houseNameTextField.layer.borderWidth = 0
                isNameSatisfied = text.count > 0
            }
            
            houseNameNumWarningLabel.isHidden = text.count <= 16
            houseNameSpecialWarningLabel.isHidden = !text.hasSpecialCharacters()
        }
    }
}

// MARK: - extension

extension ChangeHouseNameViewController : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkTextField()
        checkDoneButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ChangeHouseNameViewController {
    private func patchTeamInfo(teamName: String) {
        NetworkService.shared.teams.patchTeamInfo(teamName: teamName) { [weak self] result in
            switch result {
            case .success(_):
                self?.navigationController?.popViewController(animated: true)
            case .requestErr(let error):
                dump(error)
            default:
                print("server error")
            }
        }
    }
    
    private func getTeamInfo() {
        NetworkService.shared.teams.getTeamInfo { result in
            switch result {
            case .success(let response):
                guard let teamInfo = response as? TeamInfoResponse else { return }
                guard let teamName = teamInfo.teamName else { return }
                DispatchQueue.main.async {
                    self.houseNameTextField.text = teamName
                    self.lastName = teamName
                }
                break
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                break
            }
        }
    }
}
