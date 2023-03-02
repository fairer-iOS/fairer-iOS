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
    private var selectedDay: Date = Date() {
        didSet {
            if HouseWork.mockHouseWork[0].repeatCycle == .week {
                updateRepeatCycleDayLabel(.week, selectedDay.dayOfWeekToKoreanString)
            } else {
                updateRepeatCycleDayLabel(.month, selectedDay.singleDayToKoreanString)
            }
        }
    }
    private var houseWorks: [HouseWorksRequest] = []
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let setHouseWorkCalendarView = CalendarSpaceView()
    private let setHouseWorkCollectionView = SetHouseWorkCollectionView()
    private lazy var getManagerView: GetManagerView = {
        let view = GetManagerView()
        let action = UIAction { [weak self] _ in
            self?.showSelectManagerView()
        }
        view.addManagerButton.addAction(action, for: .touchUpInside)
        return view
    }()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
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
        label.text = TextLiteral.setManagerToastLabel
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
        label.setTextWithLineHeight(text: TextLiteral.setTimeLabel, lineHeight: 22)
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
        label.setTextWithLineHeight(text: TextLiteral.setRepeatLabel, lineHeight: 22)
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
    private let doneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.houseWorkDoneButtonText
        button.isDisabled = false
        return button
    }()
    private let datePickerView = PickDateView()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        didTappedHouseWork()
        didDeleteHouseWork()
        didTappedRepeatCycleMenuButton()
        didSelectDaysOfWeek()
        setDoneButton()
    }
    
    override func render() {
        view.addSubviews(setHouseWorkCalendarView, setHouseWorkCollectionView, doneButton, scrollView, selectManagerView, managerToastLabel, datePickerView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(getManagerView, setTimeLabel, setTimeToggle, timePicker, divider, setRepeatLabel, setRepeatToggle, repeatCycleView, repeatCycleCollectionView, repeatCycleMenu, repeatCycleDayLabel)
        
        setHouseWorkCalendarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(38)
        }
        
        setHouseWorkCollectionView.snp.makeConstraints {
            $0.top.equalTo(setHouseWorkCalendarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(134)
        }
        
        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(setHouseWorkCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(doneButton.snp.top).inset(-SizeLiteral.componentPadding)
        }
        
        contentView.snp.makeConstraints {
            $0.width.edges.equalToSuperview()
        }
        
        getManagerView.snp.makeConstraints {
            $0.top.equalToSuperview()
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
        
        repeatCycleMenu.snp.makeConstraints {
            $0.top.equalTo(repeatCycleView.snp.bottom)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.equalTo(98)
            $0.height.equalTo(76)
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
        
        datePickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setDatePicker() {
        datePickerView.isHidden = true
        datePickerView.setAction()
        
        let action = UIAction { [weak self] _ in
            self?.presentPickDateView()
        }
        setHouseWorkCalendarView.pickDateButton.addAction(action, for: .touchUpInside)
    }
    
    private func didTappedHouseWork() {
        setHouseWorkCollectionView.didTappedHouseWork = { [weak self] selectedHouseWorkIndex in
            self?.selectedHouseWorkIndex = selectedHouseWorkIndex
            self?.repeatCycleCollectionView.selectedHouseWorkIndex = selectedHouseWorkIndex
            self?.repeatCycleCollectionView.collectionView.reloadData()
            self?.updateManagerTimeRepeat(selectedHouseWorkIndex)
            self?.selectManagerView.snp.updateConstraints {
                $0.height.equalTo(0)
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
            } else if deletedHouseWorkIndex == self?.selectedHouseWorkIndex {
                self?.updateManagerTimeRepeat(deletedHouseWorkIndex)
            } else if deletedHouseWorkIndex < self?.selectedHouseWorkIndex ?? 0 {
                self?.selectedHouseWorkIndex -= 1
                self?.repeatCycleCollectionView.selectedHouseWorkIndex -= 1
                self?.updateManagerTimeRepeat(self?.selectedHouseWorkIndex ?? 0)
            } else {
                self?.updateManagerTimeRepeat(self?.selectedHouseWorkIndex ?? 0)
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
        if selectManagerView.selectManagerCollectionView.selectedManagerList.isEmpty {
            showToast()
        } else {
            selectManagerView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            addAnimation()
            getManagerView.getManagerCollectionView.selectedMemberList = selectManagerView.selectManagerCollectionView.selectedManagerList
            HouseWork.mockHouseWork[selectedHouseWorkIndex].manager = selectManagerView.selectManagerCollectionView.selectedManagerList
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
            HouseWork.mockHouseWork[selectedHouseWorkIndex].time = TextLiteral.setHouseWorkCollectionViewCellDefaultTimeLabel
            setHouseWorkCollectionView.collectionView.reloadData()
        }
    }
    
    private func didTimeChanged() {
        let time = timePicker.date.timeToKoreanString
        HouseWork.mockHouseWork[selectedHouseWorkIndex].time = time
        setHouseWorkCollectionView.collectionView.reloadData()
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
                $0.bottom.equalToSuperview().inset(40)
            }
            HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatCycle = RepeatType.week
            repeatCycleView.repeatCycleButtonLabel.text = RepeatType.week.rawValue
            updateRepeatCycleDayLabel(.week, selectedDay.dayOfWeekToKoreanString)
            repeatCycleCollectionView.selectedDaysOfWeek = []
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
            HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatCycle = nil
            HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatPattern = nil
            repeatCycleMenu.isHidden = true
        }
        addAnimation()
    }
    
    private func didTappedRepeatCycleButton() {
        repeatCycleMenu.isHidden.toggle()
    }
    
    private func didTappedRepeatCycleMenuButton() {
        repeatCycleMenu.didTappedRepeatCycleMenuButton = { [weak self] repeatCycle in
            switch repeatCycle {
            case .week:
                self?.repeatCycleCollectionView.snp.updateConstraints {
                    $0.height.equalTo(40)
                }
                self?.updateRepeatCycleDayLabel(.week, self?.selectedDay.dayOfWeekToKoreanString ?? Date().dayOfWeekToKoreanString)
                HouseWork.mockHouseWork[0].repeatPattern = nil
                self?.repeatCycleCollectionView.selectedDaysOfWeek = []
            case .month:
                self?.repeatCycleCollectionView.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                self?.updateRepeatCycleDayLabel(.month, self?.selectedDay.singleDayToKoreanString ?? Date().singleDayToKoreanString)
            }
            HouseWork.mockHouseWork[self?.selectedHouseWorkIndex ?? 0].repeatCycle = repeatCycle
            self?.repeatCycleView.repeatCycleButtonLabel.text = repeatCycle.rawValue
            self?.repeatCycleMenu.isHidden = true
        }
    }
    
    private func didSelectDaysOfWeek() {
        repeatCycleCollectionView.didSelectDaysOfWeek = { [weak self] selectedDays in
            var sortedDays: [String] = []
            for day in selectedDays.sorted(){
                sortedDays.append(String(day.dropFirst(1)))
            }
            let selectedDaysOfWeek = selectedDays.isEmpty ? self?.selectedDay.dayOfWeekToKoreanString : sortedDays.joined(separator: ", ")
            self?.updateRepeatCycleDayLabel(.week, selectedDaysOfWeek ?? Date().dayOfWeekToKoreanString)
            HouseWork.mockHouseWork[self?.selectedHouseWorkIndex ?? 0].repeatPattern = sortedDays
        }
    }
    
    private func isTimeSelected(_ houseWork: Int) {
        if HouseWork.mockHouseWork[houseWork].time == TextLiteral.setHouseWorkCollectionViewCellDefaultTimeLabel {
            setTimeToggle.isOn = false
            timePicker.snp.updateConstraints {
                $0.top.equalTo(setTimeLabel.snp.bottom)
                $0.height.equalTo(0)
            }
        } else {
            setTimeToggle.isOn = true
            timePicker.snp.updateConstraints {
                $0.top.equalTo(setTimeLabel.snp.bottom).offset(8)
                $0.height.equalTo(196.2)
            }
        }
    }
    
    private func isRepeatSelected(_ houseWork: Int) {
        switch HouseWork.mockHouseWork[houseWork].repeatCycle {
        case .week:
            setRepeatToggle.isOn = true
            openRepeatCycleView()
            repeatCycleView.repeatCycleButtonLabel.text = RepeatType.week.rawValue
            repeatCycleCollectionView.snp.updateConstraints {
                $0.height.equalTo(40)
            }
            repeatCycleCollectionView.selectedHouseWorkIndex = houseWork
            repeatCycleCollectionView.collectionView.reloadData()
            updateRepeatCycleDayLabel(.week, HouseWork.mockHouseWork[houseWork].repeatPattern?.joined(separator: ", ") ?? Date().dayOfWeekToKoreanString)
        case .month:
            setRepeatToggle.isOn = true
            openRepeatCycleView()
            repeatCycleCollectionView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            repeatCycleView.repeatCycleButtonLabel.text = RepeatType.month.rawValue
            updateRepeatCycleDayLabel(.month, selectedDay.singleDayToKoreanString)
        case .none:
            setRepeatToggle.isOn = false
            closeRepeatCycleView()
            repeatCycleCollectionView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
        }
    }
    
    private func updateManagerTimeRepeat(_ houseWork: Int) {
        getManagerView.getManagerCollectionView.selectedMemberList = HouseWork.mockHouseWork[houseWork].manager
        isTimeSelected(houseWork)
        isRepeatSelected(houseWork)
    }
    
    private func addAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func openRepeatCycleView() {
        repeatCycleView.snp.updateConstraints {
            $0.height.equalTo(36)
        }
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
    
    private func updateRepeatCycleDayLabel(_ type: RepeatType, _ repeatDay: String) {
        switch type {
        case .week:
            repeatCycleDayLabel.text = TextLiteral.everyWeekText + repeatDay + TextLiteral.weekText + TextLiteral.repeatText
            repeatCycleDayLabel.applyColor(to: repeatDay + TextLiteral.weekText, with: .positive20)
        case .month:
            repeatCycleDayLabel.text = TextLiteral.everyMonthText + repeatDay + TextLiteral.dayText + TextLiteral.repeatText
            repeatCycleDayLabel.applyColor(to: repeatDay + TextLiteral.dayText, with: .positive20)
        }
    }
    
    private func presentPickDateView() {
        datePickerView.isHidden = false
        datePickerView.dismissClosure = { [weak self] pickedDate, startDateWeek, yearInString, monthInString in
            self?.datePickerView.isHidden = true
            self?.setHouseWorkCalendarView.pickDateButton.dateLabel.text = pickedDate.dayToKoreanString
            self?.selectedDay = pickedDate
        }
    }
    
    private func setDoneButton() {
        let action = UIAction { [weak self] _ in
            self?.prepareHouseWorksRequest()
            if let houseWorks = self?.houseWorks {
                self?.postAddHouseWorks(body: houseWorks)
            }
        }
        doneButton.addAction(action, for: .touchUpInside)
    }
    
    private func prepareHouseWorksRequest() {
        // FIXME: - data binding & model 수정 필요
        let houseWork = HouseWorksRequest(assignees: [1, 2], houseWorkName: "창 청소", repeatCycle: "W", repeatPattern: "monday, sunday", scheduledDate: "2022-07-02", scheduledTime: "10:00", space: "LIVINGROOM")
        self.houseWorks.append(houseWork)
    }
}

// MARK: - extension

extension SetHouseWorkViewController {
    private func postAddHouseWorks(body: [HouseWorksRequest]) {
        NetworkService.shared.houseWorks.postAddHouseWorksAPI(body: body) { response in
            
        }
    }
}
