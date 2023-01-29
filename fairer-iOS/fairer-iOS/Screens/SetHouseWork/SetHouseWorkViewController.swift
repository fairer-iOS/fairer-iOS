//
//  SetHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/19.
//

import UIKit

import SnapKit

final class SetHouseWorkViewController: BaseViewController {
    
    private var selectedHouseWorkIndex: Int = 0
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let setHouseWorkCalendarView = SetHouseWorkCalendarView()
    private let setHouseWorkCollectionView = SetHouseWorkCollectionView()
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
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko-KR")
        picker.timeZone = .autoupdatingCurrent
        let action = UIAction { [weak self] _ in
            self?.didTimeChanged()
        }
        picker.addAction(action, for: .valueChanged)
        return picker
    }()
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private let setRepeatLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "반복하기", lineHeight: 22)
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
    private let repeatCycleMenu = RepeatCycleMenu()
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
        didTappedHouseWork()
        didDeleteHouseWork()
        didTappedRepeatCycleMenuButton()
        didSelectDaysOfWeek()
    }
    
    override func render() {
        view.addSubview(setHouseWorkCalendarView)
        setHouseWorkCalendarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(38)
        }
        
        view.addSubview(setHouseWorkCollectionView)
        setHouseWorkCollectionView.snp.makeConstraints {
            $0.top.equalTo(setHouseWorkCalendarView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(134)
        }
        
        view.addSubview(getManagerView)
        getManagerView.snp.makeConstraints {
            $0.top.equalTo(setHouseWorkCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        view.addSubview(setTimeLabel)
        setTimeLabel.snp.makeConstraints {
            $0.top.equalTo(getManagerView.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(setTimeToggle)
        setTimeToggle.snp.makeConstraints {
            $0.centerY.equalTo(setTimeLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(timePicker)
        timePicker.snp.makeConstraints {
            $0.top.equalTo(setTimeLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(0)
        }
        
        view.addSubview(divider)
        divider.snp.makeConstraints {
            $0.top.equalTo(timePicker.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(2)
        }
        
        view.addSubview(setRepeatLabel)
        setRepeatLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(setRepeatToggle)
        setRepeatToggle.snp.makeConstraints {
            $0.centerY.equalTo(setRepeatLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(repeatCycleView)
        repeatCycleView.snp.makeConstraints {
            $0.top.equalTo(setRepeatLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(31.5)
            $0.height.equalTo(0)
        }
        
        view.addSubview(repeatCycleCollectionView)
        repeatCycleCollectionView.snp.makeConstraints {
            $0.top.equalTo(repeatCycleView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        view.addSubview(repeatCycleMenu)
        repeatCycleMenu.snp.makeConstraints {
            $0.top.equalTo(repeatCycleView.snp.bottom)
            $0.trailing.equalToSuperview().inset(31.5)
            $0.width.equalTo(98)
            $0.height.equalTo(76)
        }
        
        view.addSubview(repeatCycleDayLabel)
        repeatCycleDayLabel.snp.makeConstraints {
            $0.top.equalTo(repeatCycleCollectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(selectManagerView)
        selectManagerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        view.addSubview(managerToastLabel)
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
    
    private func showSelectManagerView() {
        selectManagerView.snp.updateConstraints {
            $0.height.equalTo(341)
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        selectManagerView.selectManagerCollectionView.selectedManagerList = getManagerView.getManagerCollectionView.selectedMemberList
    }
    
    private func didTappedHouseWork() {
        setHouseWorkCollectionView.didTappedHouseWork = { [weak self] selectedHouseWorkIndex in
            self?.selectedHouseWorkIndex = selectedHouseWorkIndex
            self?.getManagerView.getManagerCollectionView.selectedMemberList = HouseWork.mockHouseWork[selectedHouseWorkIndex].manager
            
            self?.selectManagerView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            
            self?.isTimeSelected(selectedHouseWorkIndex)
            self?.repeatCycleCollectionView.selectedHouseWorkIndex = selectedHouseWorkIndex
            self?.repeatCycleCollectionView.collectionView.reloadData()
            if HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatCycle == nil {
                self?.setRepeatToggle.isOn = false
                self?.repeatCycleView.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                self?.repeatCycleView.repeatCycleButton.isHidden = true
                self?.repeatCycleView.repeatCycleLabel.isHidden = true
                self?.repeatCycleCollectionView.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                self?.repeatCycleDayLabel.isHidden = true
            } else {
                self?.setRepeatToggle.isOn = true
                self?.repeatCycleView.snp.updateConstraints {
                    $0.height.equalTo(36)
                }
                self?.repeatCycleView.repeatCycleButton.isHidden = false
                self?.repeatCycleView.repeatCycleLabel.isHidden = false
                self?.repeatCycleDayLabel.isHidden = false
                
                if HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatCycle == "매주" {
                    self?.repeatCycleCollectionView.snp.updateConstraints {
                        $0.height.equalTo(40)
                    }
                    let selectedDays = HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatPattern?.joined(separator: ", ")
                    self?.repeatCycleDayLabel.text = "매주 " + (selectedDays ?? Date().dayOfWeekToKoreanString) + "요일에 반복해요"
                    self?.repeatCycleDayLabel.applyColor(to: (selectedDays ?? Date().dayOfWeekToKoreanString) + "요일", with: .positive20)
                } else {
                    self?.updateToMonthToday()
                }
            }
        }
    }
    
    private func didDeleteHouseWork() {
        setHouseWorkCollectionView.didDeleteHouseWork = { [weak self] deletedHouseWorkIndex in
            if HouseWork.mockHouseWork.count == 0 {
                // FIXME: - 이전 페이지로 이동
            } else if deletedHouseWorkIndex == HouseWork.mockHouseWork.endIndex && deletedHouseWorkIndex == self?.selectedHouseWorkIndex ?? 0 {
                self?.selectedHouseWorkIndex -= 1
                self?.repeatCycleCollectionView.selectedHouseWorkIndex -= 1
                self?.updateManagerTimeRepeat(deletedHouseWorkIndex - 1)
            } else if deletedHouseWorkIndex < self?.selectedHouseWorkIndex ?? 0 {
                self?.selectedHouseWorkIndex -= 1
                self?.repeatCycleCollectionView.selectedHouseWorkIndex -= 1
                self?.updateManagerTimeRepeat(self?.selectedHouseWorkIndex ?? 0)
            } else if deletedHouseWorkIndex == self?.selectedHouseWorkIndex {
                self?.updateManagerTimeRepeat(deletedHouseWorkIndex)
            } else {
                self?.updateManagerTimeRepeat(self?.selectedHouseWorkIndex ?? 0)
            }
        }
    }
    
    private func didTappedCancelButton() {
        selectManagerView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlDown, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        selectManagerView.selectManagerCollectionView.selectedManagerList = getManagerView.getManagerCollectionView.selectedMemberList
    }
    
    private func didTappedConfirmButton() {
        if !selectManagerView.selectManagerCollectionView.selectedManagerList.isEmpty {
            selectManagerView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlDown, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            getManagerView.getManagerCollectionView.selectedMemberList = selectManagerView.selectManagerCollectionView.selectedManagerList
            HouseWork.mockHouseWork[selectedHouseWorkIndex].manager = selectManagerView.selectManagerCollectionView.selectedManagerList
        } else {
            showToast()
        }
    }
    
    private func showToast() {
        UIView.animate(withDuration: 1.0, animations: {
            self.managerToastLabel.alpha = 1.0
        }, completion: { isCompleted in
            UIView.animate(withDuration: 1.0, animations: {
                self.managerToastLabel.alpha = 0
            }, completion: { isCompleted in
                self.managerToastLabel.removeFromSuperview()
            })
        })
    }
    
    private func didTappedTimeToggle() {
        if setTimeToggle.isOn {
            timePicker.snp.updateConstraints {
                $0.height.equalTo(196.2)
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            timePicker.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            
            HouseWork.mockHouseWork[selectedHouseWorkIndex].time = "하루 종일"
            setHouseWorkCollectionView.collectionView.reloadData()
        }
    }
    
    private func didTappedRepeatToggle() {
        if setRepeatToggle.isOn {
            repeatCycleView.snp.updateConstraints {
                $0.height.equalTo(36)
            }
            repeatCycleView.repeatCycleButton.isHidden = false
            repeatCycleView.repeatCycleLabel.isHidden = false
            repeatCycleView.repeatCycleButtonLabel.text = "매주"
            repeatCycleCollectionView.snp.updateConstraints {
                $0.height.equalTo(40)
            }
            repeatCycleDayLabel.isHidden = false
            updateToWeekToday()
            HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatCycle = "매주"
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            repeatCycleView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            repeatCycleView.repeatCycleButton.isHidden = true
            repeatCycleView.repeatCycleLabel.isHidden = true
            repeatCycleCollectionView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            repeatCycleDayLabel.isHidden = true
            HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatCycle = nil
            HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatPattern = nil
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func didTimeChanged() {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
        let time = timePicker.date.timeToKoreanString
        HouseWork.mockHouseWork[selectedHouseWorkIndex].time = time
        setHouseWorkCollectionView.collectionView.reloadData()
    }
    
    private func didTappedRepeatCycleButton() {
        repeatCycleMenu.isHidden.toggle()
    }
    
    private func didTappedRepeatCycleMenuButton() {
        repeatCycleMenu.didTappedRepeatCycleMenuButton = { [weak self] repeatCycle in
            if repeatCycle == "매달" {
                self?.repeatCycleCollectionView.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                
                self?.updateToMonthToday()
                HouseWork.mockHouseWork[self?.selectedHouseWorkIndex ?? 0].repeatCycle = "매달"
            } else {
                self?.repeatCycleCollectionView.snp.updateConstraints {
                    $0.height.equalTo(40)
                }
                
                self?.updateToWeekToday()
                HouseWork.mockHouseWork[self?.selectedHouseWorkIndex ?? 0].repeatCycle = "매주"
            }
            self?.repeatCycleView.repeatCycleButtonLabel.text = repeatCycle
            self?.repeatCycleMenu.isHidden = true
        }
    }
    
    private func didSelectDaysOfWeek() {
        repeatCycleCollectionView.didSelectDaysOfWeek = { [weak self] selectedDays in
            let selectedDaysOfWeek = selectedDays.isEmpty ? Date().dayOfWeekToKoreanString : selectedDays.joined(separator: ", ")
            self?.repeatCycleDayLabel.text = "매주 " + selectedDaysOfWeek + "요일에 반복해요"
            self?.repeatCycleDayLabel.applyColor(to: selectedDaysOfWeek + "요일", with: .positive20)
            HouseWork.mockHouseWork[self?.selectedHouseWorkIndex ?? 0].repeatPattern = selectedDays
        }
    }
    
    private func updateToWeekToday() {
        repeatCycleDayLabel.text = "매주 " + Date().dayOfWeekToKoreanString + "요일에 반복해요"
        repeatCycleDayLabel.applyColor(to: Date().dayOfWeekToKoreanString + "요일", with: .positive20)
        repeatCycleCollectionView.selectedDaysOfWeek = []
    }
    
    private func updateToMonthToday() {
        repeatCycleDayLabel.text = "매달 " + Date().singleDayToKoreanString + "일에 반복해요"
        repeatCycleDayLabel.applyColor(to: Date().singleDayToKoreanString + "일", with: .positive20)
    }
    
    private func isTimeSelected(_ houseWork: Int) {
        if HouseWork.mockHouseWork[houseWork].time == "하루 종일" {
            setTimeToggle.isOn = false
            timePicker.snp.updateConstraints {
                $0.height.equalTo(0)
            }
        } else {
            setTimeToggle.isOn = true
            timePicker.snp.updateConstraints {
                $0.height.equalTo(196.2)
            }
        }
    }
    
    private func isRepeatSelected(_ houseWork: Int) {
        if HouseWork.mockHouseWork[houseWork].repeatCycle == nil {
            setRepeatToggle.isOn = false
            repeatCycleView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            repeatCycleView.repeatCycleButton.isHidden = true
            repeatCycleView.repeatCycleLabel.isHidden = true
            repeatCycleCollectionView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            repeatCycleDayLabel.isHidden = true
        } else {
            setRepeatToggle.isOn = true
            repeatCycleView.snp.updateConstraints {
                $0.height.equalTo(36)
            }
            repeatCycleView.repeatCycleButton.isHidden = false
            repeatCycleView.repeatCycleLabel.isHidden = false
            repeatCycleDayLabel.isHidden = false
            
            if HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatCycle == "매주" {
                repeatCycleCollectionView.snp.updateConstraints {
                    $0.height.equalTo(40)
                }
                
                let selectedDays = HouseWork.mockHouseWork[houseWork].repeatPattern?.joined(separator: ", ")
                repeatCycleDayLabel.text = "매주 " + (selectedDays ?? Date().dayOfWeekToKoreanString) + "요일에 반복해요"
                repeatCycleDayLabel.applyColor(to: (selectedDays ?? Date().dayOfWeekToKoreanString) + "요일", with: .positive20)
                repeatCycleCollectionView.selectedHouseWorkIndex = houseWork
                repeatCycleCollectionView.collectionView.reloadData()
            } else {
                updateToMonthToday()
            }
        }
    }
    
    private func updateManagerTimeRepeat(_ houseWork: Int) {
        getManagerView.getManagerCollectionView.selectedMemberList = HouseWork.mockHouseWork[houseWork].manager
        isTimeSelected(houseWork)
        isRepeatSelected(houseWork)
    }
}
