//
//  EditHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/05/08.
//

import UIKit

import SnapKit

final class EditHouseWorkViewController: BaseViewController {
    
    private let houseWorkMaxLength = 16
    private var selectedDay: Date = Date() {
        didSet {
            if editHouseWork?.repeatCycle == "W" {
                updateRepeatCycleDayLabel(.week, selectedDay.dayOfWeekToKoreanString)
            } else {
                updateRepeatCycleDayLabel(.month, selectedDay.singleDayToKoreanString)
            }
        }
    }
    private var editHouseWork: EditHouseWorkRequest?
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TextLiteral.writeHouseWorkViewControllerDeleteLabel, for: .normal)
        button.setTitleColor(.negative20, for: .normal)
        button.titleLabel?.font = .caption1
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        return button
    }()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let writeHouseWorkCalendarView = CalendarSpaceView()
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
    private let repeatCycleCollectionView = RepeatCycleCollectionView()
    private let repeatCycleMenu = RepeatCycleMenu()
    private lazy var repeatCycleDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray400
        label.font = .body2
        label.isHidden = true
        return label
    }()
    private let doneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.editHouseWorkViewControllerDoneButtonText
        button.isDisabled = true
        return button
    }()
    private let datePickerView = PickDateView()
    private let repeatAlertView: RepeatAlertView = {
        let view = RepeatAlertView()
        view.isHidden = true
        return view
    }()
    
    // MARK: - life cycle
    
    init(editHouseWork: EditHouseWorkRequest) {
        self.editHouseWork = EditHouseWorkRequest(assignees: [11, 38], houseWorkId: 609, houseWorkName: "창 청소", repeatCycle: "W", repeatPattern: "MONDAY,SUNDAY", scheduledDate: "2023-05-02", scheduledTime: "16:02", space: "LIVINGROOM")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLatestContents()
        setDeleteButton()
        setDatePicker()
        setupNotificationCenter()
        setupDelegation()
        didTappedRepeatCycleMenuButton()
        didSelectDaysOfWeek()
        hidekeyboardWhenTappedAround()
        getTeamInfo()
        addButtonAction()
    }
    
    override func render() {
        view.addSubviews(scrollView, doneButton, selectManagerView, managerToastLabel, datePickerView, repeatAlertView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(writeHouseWorkCalendarView, houseWorkNameLabel, houseWorkNameTextField, houseWorkNameWarningLabel, getManagerView, setTimeLabel, setTimeToggle, timePicker, divider, setRepeatLabel, setRepeatToggle, repeatCycleView, repeatCycleCollectionView, repeatCycleMenu, repeatCycleDayLabel)
        
        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(doneButton.snp.top).inset(-16)
        }
        
        contentView.snp.makeConstraints {
            $0.width.edges.equalToSuperview()
        }
        
        writeHouseWorkCalendarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(38)
        }
        
        houseWorkNameLabel.snp.makeConstraints {
            $0.top.equalTo(writeHouseWorkCalendarView.snp.bottom).offset(8)
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
        
        repeatAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        let deleteButton = makeBarButtonItem(with: deleteButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = deleteButton
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setDeleteButton() {
        let action = UIAction { [weak self] _ in
            self?.repeatAlertView.isHidden = false
            self?.repeatAlertView.alertType = .delete
        }
        deleteButton.addAction(action, for: .touchUpInside)
    }
    
    private func setDatePicker() {
        datePickerView.isHidden = true
        datePickerView.setAction()
        
        let action = UIAction { [weak self] _ in
            self?.presentPickDateView()
        }
        writeHouseWorkCalendarView.pickDateButton.addAction(action, for: .touchUpInside)
    }
    
    private func setLatestContents() {
        houseWorkNameTextField.text = editHouseWork?.houseWorkName
        
        if let time = editHouseWork?.scheduledTime?.stringToTime {
            setTimeToggle.isOn = true
            timePicker.snp.updateConstraints {
                $0.top.equalTo(setTimeLabel.snp.bottom).offset(8)
                $0.height.equalTo(196.2)
            }
            timePicker.date = time
        }
        
        if editHouseWork?.repeatCycle != "O" {
            setRepeatToggle.isOn = true
            showRepeatComponents()
            if editHouseWork?.repeatCycle == "W" {
                if let dayOfWeek = editHouseWork?.repeatPattern?.components(separatedBy: ",") {
                    var koreanDayOfWeek: [String] = []
                    var collectionViewDayOfWeek: [String] = []
                    for day in dayOfWeek {
                        koreanDayOfWeek.append(String(day.englishToDayOfWeekString().dropFirst(1)))
                        collectionViewDayOfWeek.append(day.englishToDayOfWeekString())
                    }
                    updateRepeatCycleDayLabel(.week, koreanDayOfWeek.joined(separator: ", "))
                    repeatCycleView.repeatCycleButtonLabel.text = RepeatCycleType.week.repeatLabel
                    repeatCycleCollectionView.selectedDaysOfWeek = collectionViewDayOfWeek
                }
            } else {
                repeatCycleCollectionView.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                repeatCycleView.repeatCycleButtonLabel.text = RepeatCycleType.month.repeatLabel
                updateRepeatCycleDayLabel(.month, editHouseWork?.repeatPattern ?? Date().dayToString)
            }
        } else {
            setRepeatToggle.isOn = false
            hideRepeatComponents()
        }
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
                self.doneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 36)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.doneButton.transform = .identity
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
                editHouseWork?.houseWorkName = text
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
            selectManagerView.selectManagerCollectionView.selectedManagerList.forEach {
                editHouseWork?.assignees = []
                if let memberId = $0.memberId {
                    editHouseWork?.assignees?.append(memberId)
                }
            }
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
            editHouseWork?.scheduledTime = ""
        }
    }
    
    private func presentPickDateView() {
        datePickerView.isHidden = false
        datePickerView.dismissClosure = { [weak self] pickedDate, startDateWeek, yearInString, monthInString in
            self?.datePickerView.isHidden = true
            self?.writeHouseWorkCalendarView.pickDateButton.dateLabel.text = pickedDate.dayToKoreanString
            self?.selectedDay = pickedDate
        }
    }
    
    private func didTimeChanged() {
        let time = timePicker.date.dateToTimeString
        editHouseWork?.scheduledTime = time
    }
    
    private func didTappedRepeatToggle() {
        if setRepeatToggle.isOn {
            showRepeatComponents()
            repeatCycleCollectionView.selectedDaysOfWeek = []
            repeatCycleView.repeatCycleButtonLabel.text = RepeatCycleType.week.repeatLabel
            updateRepeatCycleDayLabel(.week, selectedDay.dayOfWeekToKoreanString)
            editHouseWork?.repeatCycle = RepeatCycleType.week.rawValue
            editHouseWork?.repeatPattern = Date().dayOfWeekToAPIString
        } else {
            hideRepeatComponents()
            editHouseWork?.repeatCycle = RepeatCycleType.once.rawValue
            editHouseWork?.repeatPattern = Date().dateToAPIString
        }
        addAnimation()
    }
    
    private func didTappedRepeatCycleButton() {
        repeatCycleMenu.isHidden.toggle()
    }
    
    private func addAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func updateRepeatCycleDayLabel(_ type: RepeatCycleType, _ repeatDay: String) {
        switch type {
        case .week:
            repeatCycleDayLabel.text = TextLiteral.everyWeekText + repeatDay + TextLiteral.weekText + TextLiteral.repeatText
            repeatCycleDayLabel.applyColor(to: repeatDay + TextLiteral.weekText, with: .positive20)
        case .month:
            repeatCycleDayLabel.text = TextLiteral.everyMonthText + repeatDay + TextLiteral.dayText + TextLiteral.repeatText
            repeatCycleDayLabel.applyColor(to: repeatDay + TextLiteral.dayText, with: .positive20)
        default:
            return
        }
    }
    
    private func didTappedRepeatCycleMenuButton() {
        repeatCycleMenu.didTappedRepeatCycleMenuButton = { [weak self] repeatCycle in
            switch repeatCycle {
            case .once:
                break
            case .daily:
                break
            case .week:
                self?.repeatCycleCollectionView.snp.updateConstraints {
                    $0.height.equalTo(40)
                }
                self?.updateRepeatCycleDayLabel(.week, self?.selectedDay.dayOfWeekToKoreanString ?? Date().dayOfWeekToKoreanString)
                self?.editHouseWork?.repeatPattern = Date().dayOfWeekToAPIString
            case .month:
                self?.repeatCycleCollectionView.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                self?.editHouseWork?.repeatPattern = Date().singleDayToKoreanString
                self?.updateRepeatCycleDayLabel(.month, self?.selectedDay.singleDayToKoreanString ?? Date().singleDayToKoreanString)
            }
            self?.editHouseWork?.repeatCycle = repeatCycle.rawValue
            self?.repeatCycleCollectionView.selectedDaysOfWeek = []
            self?.repeatCycleView.repeatCycleButtonLabel.text = repeatCycle.repeatLabel
            self?.repeatCycleMenu.isHidden = true
        }
    }
    
    private func didSelectDaysOfWeek() {
        repeatCycleCollectionView.didSelectDaysOfWeek = { [weak self] selectedDays in
            var sortedDays: [String] = []
            var sortedDaysInAPIString: [String] = []
            for day in selectedDays.sorted(){
                sortedDays.append(String(day.dropFirst(1)))
                sortedDaysInAPIString.append(day.dayOfWeekToAPIString())
            }
            let selectedDaysOfWeek = selectedDays.isEmpty ? self?.selectedDay.dayOfWeekToKoreanString : sortedDays.joined(separator: ", ")
            self?.updateRepeatCycleDayLabel(.week, selectedDaysOfWeek ?? Date().dayOfWeekToKoreanString)
            self?.editHouseWork?.repeatPattern = sortedDaysInAPIString.joined(separator: ",")
        }
    }
    
    private func showRepeatComponents() {
        repeatCycleView.snp.updateConstraints {
            $0.height.equalTo(36)
        }
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
        repeatCycleView.repeatCycleLabel.isHidden = false
        repeatCycleView.repeatCycleButton.isHidden = false
        repeatCycleDayLabel.isHidden = false
    }
    
    private func hideRepeatComponents() {
        repeatCycleView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
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
        repeatCycleView.repeatCycleLabel.isHidden = true
        repeatCycleView.repeatCycleButton.isHidden = true
        repeatCycleDayLabel.isHidden = true
        repeatCycleMenu.isHidden = true
    }
}

// MARK: - extension

extension EditHouseWorkViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkMaxLength()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EditHouseWorkViewController {
    private func getTeamInfo() {
        NetworkService.shared.teams.getTeamInfo { result in
            switch result {
            case .success(let response):
                guard let teamInfo = response as? TeamInfoResponse else { return }
                guard let membersInfo = teamInfo.members else { return }
                DispatchQueue.main.async {
                    let selectedMemberList = membersInfo.filter { member in
                        self.editHouseWork?.assignees?.contains { assignee in
                            member.memberId == assignee
                        } ?? false
                    }
                    self.getManagerView.getManagerCollectionView.selectedMemberList = selectedMemberList
                    self.selectManagerView.selectManagerCollectionView.selectedManagerList = selectedMemberList
                    self.selectManagerView.selectManagerCollectionView.totalMemberList = membersInfo
                }
                break
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                break
            }
        }
    }
    
    private func putEditHouseWork(body: EditHouseWorkRequest) {
        NetworkService.shared.houseWorks.putEditHouseWork(body: body) { result in
            switch result {
            case .success(let response):
                dump(response)
                break
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                break
            }
        }
    }
    
    private func deleteHouseWork(body: DeleteHouseWorkRequest) {
        NetworkService.shared.houseWorks.deleteHouseWork(body: body) { result in
            switch result {
            case .success(let response):
                dump(response)
                break
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                break
            }
        }
    }
}

extension EditHouseWorkViewController {
    private func addButtonAction() {
        let action = UIAction { [weak self] _ in
            self?.repeatAlertView.alertType = .edit
            self?.repeatAlertView.isHidden = false
            self?.popToHome()
        }
        doneButton.addAction(action, for: .touchUpInside)
    }
    
    private func popToHome() {
        self.navigationController?.popToViewController(ofClass: HomeViewController.self)
    }
}
