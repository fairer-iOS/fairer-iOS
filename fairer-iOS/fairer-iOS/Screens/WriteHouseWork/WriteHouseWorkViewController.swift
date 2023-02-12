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
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let writeHouseWorkCalendarView = SetHouseWorkCalendarView()
    private let houseWorkNameLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.writeHouseWorkViewControllerHouseWorkNameLabel, lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private let houseWorkNameTextField = TextField(type: .small, placeHolder: TextLiteral.writeHouseWorkViewControllerHouseWorkNameTextFieldPlaceholderText)
    private let houseWorkNameWarningLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.writeHouseWorkViewControllerHouseWorkNameWarningLabel, lineHeight: 22)
        label.textColor = .negative20
        label.font = .body2
        return label
    }()
    private lazy var getManagerView: GetManagerView = {
        let view = GetManagerView()
        let action = UIAction { [weak self] _ in
            self?.showSelectManagerView()
        }
        view.addManagerButton.addAction(action, for: .touchUpInside)
        return view
    }()
    private lazy var selectManagerView: SelectManagerView = {
        let view = SelectManagerView()
        let cancelAction = UIAction { [weak self] _ in
            self?.didTappedCancelButton()
        }
        let confirmAction = UIAction { [weak self] _ in
            self?.didTappedConfirmButton()
        }
        view.cancelButton.addAction(cancelAction, for: .touchUpInside)
        view.confirmButton.addAction(confirmAction, for: .touchUpInside)
        return view
    }()
    private let managerToastLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.setHouseWorkManagerToastLabel
        label.textColor = .white
        label.font = .title2
        label.backgroundColor = .gray700
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.alpha = 0
        return label
    }()
    private let setTimeLabel: UILabel = {
        let label = UILabel()
        // FIXME: - 71 PR 머지되면 common textliteral 로 변경
        label.setTextWithLineHeight(text: "시간설정", lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private lazy var setTimeToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.onTintColor = .blue
        toggle.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        let action = UIAction { [weak self] _ in
            self?.didTappedTimeToggle()
        }
        toggle.addAction(action, for: .touchUpInside)
        return toggle
    }()
    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko-KR")
        picker.timeZone = .autoupdatingCurrent
        return picker
    }()
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private let setRepeatLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.setHouseWorkViewControllerSetRepeatLabel, lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private lazy var setRepeatToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.onTintColor = .blue
        toggle.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        let action = UIAction { [weak self] _ in
            self?.didTappedRepeatToggle()
        }
        toggle.addAction(action, for: .touchUpInside)
        return toggle
    }()
    private lazy var repeatCycleView: RepeatCycleView = {
        let view = RepeatCycleView()
        let action = UIAction { [weak self] _ in
            self?.didTappedRepeatCycleButton()
        }
        view.repeatCycleButton.addAction(action, for: .touchUpInside)
        return view
    }()
    private let repeatCycleCollectionView = RepeatCycleCollectionView()
    private lazy var repeatCycleDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray400
        label.font = .body2
        label.isHidden = true
        return label
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationCenter()
        setupDelegation()
    }
    
    override func render() {
        view.addSubviews(scrollView, selectManagerView, managerToastLabel)
        scrollView.addSubview(contentView)
        contentView.addSubviews(writeHouseWorkCalendarView, houseWorkNameLabel, houseWorkNameTextField, houseWorkNameWarningLabel, getManagerView, setTimeLabel, setTimeToggle, timePicker, divider, setRepeatLabel, setRepeatToggle, repeatCycleView, repeatCycleCollectionView, repeatCycleDayLabel)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.edges.equalToSuperview()
        }
        
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
        
        getManagerView.snp.makeConstraints {
            $0.top.equalTo(houseWorkNameTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        setTimeLabel.snp.makeConstraints {
            $0.top.equalTo(getManagerView.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        setTimeToggle.snp.makeConstraints {
            $0.centerY.equalTo(setTimeLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        timePicker.snp.makeConstraints {
            $0.top.equalTo(setTimeLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(0)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(timePicker.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(2)
        }
        
        setRepeatLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        setRepeatToggle.snp.makeConstraints {
            $0.centerY.equalTo(setRepeatLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(0)
        }
        
        repeatCycleView.snp.makeConstraints {
            $0.top.equalTo(setRepeatLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(0)
        }
        
        repeatCycleCollectionView.snp.makeConstraints {
            $0.top.equalTo(repeatCycleView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        repeatCycleDayLabel.snp.makeConstraints {
            $0.top.equalTo(repeatCycleCollectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        selectManagerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        managerToastLabel.snp.makeConstraints {
            $0.bottom.equalTo(selectManagerView.snp.top).offset(-10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(36)
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
                getManagerView.snp.updateConstraints {
                    $0.top.equalTo(houseWorkNameTextField.snp.bottom).offset(38)
                }
            } else {
                houseWorkNameTextField.layer.borderWidth = 0
                houseWorkNameWarningLabel.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                getManagerView.snp.updateConstraints {
                    $0.top.equalTo(houseWorkNameTextField.snp.bottom).offset(8)
                }
            }
        }
    }
    
    private func showSelectManagerView() {
        selectManagerView.snp.updateConstraints {
            $0.height.equalTo(341)
        }
        
        addAnimation()
        
        selectManagerView.selectManagerCollectionView.selectedManagerList = getManagerView.getManagerCollectionView.selectedMemberList
    }
    
    private func didTappedCancelButton() {
        selectManagerView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        
        addAnimation()
        
        selectManagerView.selectManagerCollectionView.selectedManagerList = getManagerView.getManagerCollectionView.selectedMemberList
    }
    
    private func didTappedConfirmButton() {
        if !selectManagerView.selectManagerCollectionView.selectedManagerList.isEmpty {
            selectManagerView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            
            addAnimation()
            
            getManagerView.getManagerCollectionView.selectedMemberList = selectManagerView.selectManagerCollectionView.selectedManagerList
        } else {
            showToast()
        }
    }
    
    private func showToast() {
        UIView.animate(withDuration: 1.0, animations: {
            self.managerToastLabel.isHidden = false
            self.managerToastLabel.alpha = 1.0
        }, completion: { isCompleted in
            UIView.animate(withDuration: 1.0, animations: {
                self.managerToastLabel.alpha = 0
            }, completion: { isCompleted in
                self.managerToastLabel.isHidden = true
            })
        })
    }
    
    private func didTappedTimeToggle() {
        if setTimeToggle.isOn {
            timePicker.snp.updateConstraints {
                $0.top.equalTo(setTimeLabel.snp.bottom).offset(8)
                $0.height.equalTo(196.2)
            }
            addAnimation()
        } else {
            timePicker.snp.updateConstraints {
                $0.top.equalTo(setTimeLabel.snp.bottom)
                $0.height.equalTo(0)
            }
        }
    }
    
    private func didTappedRepeatToggle() {
        if setRepeatToggle.isOn {
            openRepeatCycleView()
            repeatCycleCollectionView.snp.updateConstraints {
                $0.height.equalTo(40)
            }
            setRepeatToggle.snp.remakeConstraints {
                $0.centerY.equalTo(setRepeatLabel.snp.centerY)
                $0.trailing.equalToSuperview().inset(20)
            }
            repeatCycleDayLabel.snp.remakeConstraints {
                $0.top.equalTo(repeatCycleCollectionView.snp.bottom).offset(16)
                $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
                $0.bottom.equalTo(0)
            }
            updateRepeatCycleDayLabel(.week, Date().dayOfWeekToKoreanString)
        } else {
            closeRepeatCycleView()
            repeatCycleCollectionView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            setRepeatToggle.snp.remakeConstraints {
                $0.centerY.equalTo(setRepeatLabel.snp.centerY)
                $0.trailing.equalToSuperview().inset(20)
                $0.bottom.equalTo(0)
            }
            repeatCycleDayLabel.snp.remakeConstraints {
                $0.top.equalTo(repeatCycleCollectionView.snp.bottom).offset(16)
                $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            }
        }
        addAnimation()
    }
    
    private func didTappedRepeatCycleButton() {
        print("cycle button")
    }
    
    private func openRepeatCycleView() {
        repeatCycleView.snp.updateConstraints {
            $0.height.equalTo(36)
        }
        repeatCycleView.repeatCycleButtonLabel.text = RepeatType.week.rawValue
        repeatCycleView.repeatCycleLabel.isHidden = false
        repeatCycleView.repeatCycleButton.isHidden = false
        repeatCycleDayLabel.isHidden = false
    }
    
    private func closeRepeatCycleView() {
        repeatCycleView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        repeatCycleView.repeatCycleLabel.isHidden = true
        repeatCycleView.repeatCycleButton.isHidden = true
        repeatCycleDayLabel.isHidden = true
    }
    
    private func addAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func updateRepeatCycleDayLabel(_ type: RepeatType, _ repeatDay: String) {
        switch type {
        case .week:
            repeatCycleDayLabel.text = TextLiteral.setHouseWorkViewControllerEveryWeek + repeatDay + TextLiteral.setHouseWorkViewControllerWeek + TextLiteral.setHouseWorkViewControllerRepeat
            repeatCycleDayLabel.applyColor(to: repeatDay + TextLiteral.setHouseWorkViewControllerWeek, with: .positive20)
        case .month:
            repeatCycleDayLabel.text = TextLiteral.setHouseWorkViewControllerEveryMonth + repeatDay + TextLiteral.setHouseWorkViewControllerDay + TextLiteral.setHouseWorkViewControllerRepeat
            repeatCycleDayLabel.applyColor(to: repeatDay + TextLiteral.setHouseWorkViewControllerDay, with: .positive20)
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
