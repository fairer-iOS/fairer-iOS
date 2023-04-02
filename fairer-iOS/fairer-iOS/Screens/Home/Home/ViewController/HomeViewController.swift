//
//  HomeViewController.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class HomeViewController: BaseViewController {
    
    private var teamId: Int?
    private var ruleArray: [RuleData]?
    private var isScrolled = false
    private lazy var leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    private lazy var rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    private var selectedMemberId: Int?
    private var myId: Int?
    private lazy var divideIndex: Int = 0
    private lazy var workTotalNum: Int = 0
    private lazy var notFinishedWorkSum: Int = 0
    private lazy var finishedWorkSum: Int = 0 {
        didSet {
            self.notFinishedWorkSum = workTotalNum - finishedWorkSum
            self.homeWeekCalendarCollectionView.countWorkLeft = String(notFinishedWorkSum)
        }
    }
    private lazy var userName: String = String() {
        didSet {
            self.nameTitleLabel.text = userName
        }
    }
    private var pickDayWorkInfo: DayHouseWorks? {
        didSet {
            self.calendarDailyTableView.reloadData()
        }
    }
    private var countWorkDoneInWeek: Int? {
        didSet {
            guard let countWorkDoneInWeek = countWorkDoneInWeek else { return }
            guard let lastDateInFullDateList = homeWeekCalendarCollectionView.fullDateList.last?.stringToDate else { return }
            guard let finalLastDateInFullDateList = Calendar.current.date(byAdding: .day, value: 1, to: lastDateInFullDateList) else { return }
            if countWorkDoneInWeek == 0 {
                self.countDoneTitleLabel.text = "아직 집안일을 하지 않으셨네요."
            } else if Date().dateCompare(fromDate: finalLastDateInFullDateList) == "Past" {
                self.countDoneTitleLabel.text = "저번주에 \(countWorkDoneInWeek)개 만큼 해주셨어요!"
            } else {
                self.countDoneTitleLabel.text = "이번주에 \(countWorkDoneInWeek)개 만큼 해주셨어요!"
            }
        }
    }
    
    // MARK: - property
    
    private let logoImage = UIImageView(image: ImageLiterals.imgHomeLogo)
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(ImageLiterals.settingMenu, for: .normal)
        button.tintColor = .black
        return button
    }()
    private let toolBarView = HomeViewControllerToolBar()
    private lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .title1
        label.applyColor(to: userName, with: .blue)
        label.numberOfLines = 2
        return label
    }()
    private lazy var countDoneTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .title1
        label.applyColor(to: userName, with: .blue)
        label.text = "아직 집안일을 하지 않으셨네요."
        label.numberOfLines = 2
        return label
    }()
    private lazy var titleLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    private let houseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.houseFill
        imageView.tintColor = .gray400
        return imageView
    }()
    private let homeGroupLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .gray400
        return label
    }()
    private let homeGroupCollectionView = HomeGroupCollectionView()
    private let homeRuleView = HomeRuleView()
    private let homeDivider: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray100.cgColor
        return view
    }()
    private let homeCalenderView = HomeCalendarView()
    private let homeWeekCalendarCollectionView = HomeWeekCalendarCollectionView()
    private let calendarDailyTableView: UITableView = {
        let calendarDailyTableView = UITableView(frame: .zero, style: .insetGrouped)
        calendarDailyTableView.register(CalendarDailyTableViewCell.self, forCellReuseIdentifier: CalendarDailyTableViewCell.identifier)
        calendarDailyTableView.showsVerticalScrollIndicator = false
        calendarDailyTableView.separatorStyle = .none
        calendarDailyTableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
        calendarDailyTableView.sectionFooterHeight = 0
        calendarDailyTableView.backgroundColor = .white
        return calendarDailyTableView
    }()
    let datePickerView: PickDateView = {
        let view = PickDateView()
        return view
    }()
    private let emptyHouseWorkImage = UIImageView(image: ImageLiterals.emptyHouseWork)
    
    // MARK: - life cycle
    
    deinit {
        print("HomeViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDelegate()
        self.setWeekCalendarSwipeGesture()
        self.setButtonEvent()
        self.setDatePicker()
        self.setNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getDivideIndex()
        if homeWeekCalendarCollectionView.datePickedByOthers == "" {
            self.getHouseWorksByDate(
                isOwn: self.checkMemeberCellIsOwn(),
                startDate: homeWeekCalendarCollectionView.todayDateInString,
                endDate: homeWeekCalendarCollectionView.todayDateInString
            )
        } else {
            self.getHouseWorksByDate(
                isOwn: self.checkMemeberCellIsOwn(),
                startDate: homeWeekCalendarCollectionView.datePickedByOthers,
                endDate: homeWeekCalendarCollectionView.datePickedByOthers
            )
        }
        self.getTeamInfo()
        self.getRules()
    }
    
    override func configUI() {
        super.configUI()
        setupToolBarGesture()
    }
    
    override func render() {
        view.addSubviews(toolBarView,
                         titleLabelStackView,
                         houseImageView,
                         homeGroupLabel,
                         homeGroupCollectionView,
                         homeRuleView,
                         homeDivider,
                         datePickerView,
                         homeCalenderView,
                         homeWeekCalendarCollectionView,
                         calendarDailyTableView,
                         emptyHouseWorkImage)
        
        toolBarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(76)
        }
        
        titleLabelStackView.addArrangedSubview(nameTitleLabel)
        titleLabelStackView.addArrangedSubview(countDoneTitleLabel)
        
        titleLabelStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.height.equalTo(45)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        houseImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabelStackView.snp.bottom).offset(16)
            $0.height.equalTo(18)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        homeGroupLabel.snp.makeConstraints {
            $0.leading.equalTo(houseImageView.snp.trailing).offset(4)
            $0.height.equalTo(18)
            $0.centerY.equalTo(houseImageView.snp.centerY)
        }
        
        homeGroupCollectionView.snp.makeConstraints {
            $0.top.equalTo(houseImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        homeRuleView.snp.makeConstraints {
            $0.top.equalTo(homeGroupCollectionView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(35)
        }
        
        homeDivider.snp.makeConstraints {
            $0.top.equalTo(homeGroupLabel.snp.bottom).offset(144)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(2)
        }
        
        homeCalenderView.snp.makeConstraints {
            $0.top.equalTo(homeDivider.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(40)
        }
        
        homeWeekCalendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(homeCalenderView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(95)
        }
        
        calendarDailyTableView.snp.makeConstraints {
            $0.top.equalTo(homeWeekCalendarCollectionView.snp.bottom).offset(-15)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(toolBarView.snp.top)
        }
        
        datePickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        emptyHouseWorkImage.snp.makeConstraints {
            $0.top.equalTo(homeWeekCalendarCollectionView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(156)
            $0.height.equalTo(240)
        }
    }
    
    //MARK: - set up
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let logoView = makeBarButtonItem(with: logoImage)
        let rightButton = makeBarButtonItem(with: profileButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = logoView
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setupAlphaNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let logoView = makeBarButtonItem(with: logoImage)
        let rightButton = makeBarButtonItem(with: profileButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = logoView
        navigationItem.rightBarButtonItem = rightButton
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupDelegate() {
        self.calendarDailyTableView.delegate = self
        self.calendarDailyTableView.dataSource = self
    }
    
    private func setupToolBarGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addTapGesture))
        toolBarView.addGestureRecognizer(tapGesture)
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(observeWeekCalendar(notification:)), name: Notification.Name.date, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observeMemberCollectionView(notification:)), name: Notification.Name.member, object: nil)
    }
    
    private func setWeekCalendarSwipeGesture() {
        leftSwipeGestureRecognizer.direction = .left
        rightSwipeGestureRecognizer.direction = .right
        homeWeekCalendarCollectionView.addGestureRecognizer(leftSwipeGestureRecognizer)
        homeWeekCalendarCollectionView.addGestureRecognizer(rightSwipeGestureRecognizer)
    }
    
    private func setDatePicker() {
        datePickerView.isHidden = true
        datePickerView.dismissClosure = { [weak self] pickedDate, startDateWeek, yearInString, monthInString in
            guard let self = self else {
                return
            }
            self.homeWeekCalendarCollectionView.startOfWeekDate = startDateWeek
            self.homeWeekCalendarCollectionView.datePickedByOthers = pickedDate.dateToString
            self.homeWeekCalendarCollectionView.fullDateList = self.homeWeekCalendarCollectionView.getThisWeekInDate()
            self.homeCalenderView.calendarMonthLabelButton.setTitle("\(yearInString)년 \(monthInString)월", for: .normal)
            self.datePickerView.isHidden = true
            self.getHouseWorksByDate(
                isOwn: self.checkMemeberCellIsOwn(),
                startDate: pickedDate.dateToString,
                endDate: pickedDate.dateToString
            )
            self.setupNavigationBar()
        }
        datePickerView.changeClosure = { [weak self] val in
            guard self != nil else {
                return
            }
        }
        homeWeekCalendarCollectionView.yearMonthDateByTouchedCell = { [weak self] yearDate in
            guard let self = self else {
                return
            }
            let seporateResult = yearDate.components(separatedBy: ".")
            self.homeCalenderView.calendarMonthLabelButton.setTitle("\(seporateResult[0])년 \(seporateResult[1])월", for: .normal)
        }
    }
    
    // MARK: - func
    
    private func setButtonEvent() {
        self.datePickerView.setAction()
        let moveToTodayDateButtonAction = UIAction { [weak self] _ in
            self?.moveToTodayDate()
        }
        let moveToTodayDatePickerButtonAction = UIAction { [weak self] _ in
            self?.moveToDatePicker()
        }
        self.homeCalenderView.todayButton.addAction(moveToTodayDateButtonAction, for: .touchUpInside)
        self.homeCalenderView.calendarMonthLabelButton.addAction(moveToTodayDatePickerButtonAction, for: .touchUpInside)
        self.homeCalenderView.calendarMonthPickButton.addAction(moveToTodayDatePickerButtonAction, for: .touchUpInside)
    }
    
    private func setHomeRuleLabel() {
        var index = 0
        
        guard let rules = ruleArray else {
            homeRuleView.homeRuleDescriptionLabel.text = TextLiteral.homeRuleViewRuleDescriptionLabel
            return
        }
        homeRuleView.homeRuleDescriptionLabel.text = rules[index].ruleName
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            guard let count = self?.ruleArray?.count else { return }
            self?.homeRuleView.homeRuleDescriptionLabel.text = self?.ruleArray?[index].ruleName
            index += 1
            if index > count - 1 {
                index = 0
            }
        }
    }
    
    private func getDivideIndex() {
        self.divideIndex = 0
        
        for divider in self.pickDayWorkInfo?.houseWorks ?? [HouseWorkData]() {
            if divider.success == true { continue }
            self.divideIndex = self.divideIndex + 1
        }
    }
    
    private func listCompleteHouseWorkLast(WorkList: [HouseWorkData]) -> [HouseWorkData] {
        var notFinishedList = [HouseWorkData]()
        var finishedList = [HouseWorkData]()
        
        for dummy in WorkList {
            if dummy.success == true { finishedList.append(dummy) }
            else { notFinishedList.append(dummy) }
        }
        return notFinishedList + finishedList
    }
    
    private func countDoneHouseWork(WorkList: [HouseWorkData]) -> Int {
        var finishedHouseWorkNum = 0
        
        for dummy in WorkList {
            if dummy.success == true { finishedHouseWorkNum = finishedHouseWorkNum + 1}
        }
        return finishedHouseWorkNum
    }
    
    private func moveToTodayDate() {
        self.homeCalenderView.calendarMonthLabelButton.setTitle("\(Date().yearToString)년 \(Date().monthToString)월", for: .normal)
        self.homeWeekCalendarCollectionView.startOfWeekDate = Date().startOfWeek
        self.homeWeekCalendarCollectionView.datePickedByOthers = Date().dateToString
        self.homeWeekCalendarCollectionView.fullDateList = self.homeWeekCalendarCollectionView.getThisWeekInDate()
        self.getHouseWorksByDate(
            isOwn: self.checkMemeberCellIsOwn(),
            startDate: self.homeWeekCalendarCollectionView.datePickedByOthers,
            endDate: self.homeWeekCalendarCollectionView.datePickedByOthers
        )
    }
    
    private func moveToDatePicker() {
        if self.homeWeekCalendarCollectionView.datePickedByOthers != "" {
            self.datePickerView.datePicker.setDate(self.homeWeekCalendarCollectionView.datePickedByOthers.stringToDate ?? Date(), animated: false)
        }
        self.datePickerView.isHidden = false
        self.view.bringSubviewToFront(datePickerView)
        self.setupAlphaNavigationBar()
    }
    
    private func scrollDidStart(){
        self.homeRuleView.homeRuleLabel.isHidden = true
        self.homeRuleView.homeRuleDescriptionLabel.isHidden = true
        self.homeGroupCollectionView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        self.homeRuleView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        self.homeDivider.snp.updateConstraints {
            $0.top.equalTo(self.homeGroupLabel.snp.bottom).offset(16)
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func scrollDidEnd() {
        self.homeDivider.snp.updateConstraints {
            $0.top.equalTo(self.homeGroupLabel.snp.bottom).offset(144)
        }
        self.homeGroupCollectionView.snp.updateConstraints {
            $0.height.equalTo(70)
        }
        self.homeRuleView.snp.updateConstraints {
            $0.height.equalTo(35)
        }
        self.homeRuleView.homeRuleLabel.isHidden = false
        self.homeRuleView.homeRuleDescriptionLabel.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func checkMemeberCellIsOwn() -> Bool {
        if myId == selectedMemberId { return true }
        else { return false }
    }

    
    // MARK: - networking data binding
    
    private func getHouseWorksByDate(isOwn: Bool, startDate: String, endDate: String) {
        DispatchQueue.main.async {
            LoadingView.showLoading()
        }
        DispatchQueue.global().async {
            if isOwn {
                self.getDateHouseWork(
                    fromDate: startDate.replacingOccurrences(of: ".", with: "-"),
                    toDate: endDate.replacingOccurrences(of: ".", with: "-")
                ) { response in
                    DispatchQueue.main.async {
                        LoadingView.hideLoading()
                        if let response = response[self.homeWeekCalendarCollectionView.datePickedByOthers.replacingOccurrences(of: ".", with: "-")] {
                            self.pickDayWorkInfo = response
                            self.divideIndex = response.countLeft
                            self.workTotalNum = response.countLeft + response.countDone
                            self.pickDayWorkInfo?.houseWorks = self.listCompleteHouseWorkLast(WorkList: response.houseWorks ?? [HouseWorkData]())
                            if response.countDone + response.countLeft != 0 {
                                self.emptyHouseWorkImage.isHidden = true
                                self.calendarDailyTableView.isHidden = false
                            } else {
                                self.emptyHouseWorkImage.isHidden = false
                                self.calendarDailyTableView.isHidden = true
                            }
                            self.finishedWorkSum = response.countDone
                        }
                        self.bindWeekWorkDoneLable(isOwn: isOwn)
                    }
                }
            } else {
                guard let selectedMemberId = self.selectedMemberId else { return }
                self.getMemberDateHouseWork(
                    fromDate: startDate.replacingOccurrences(of: ".", with: "-"),
                    toDate: endDate.replacingOccurrences(of: ".", with: "-"),
                    teamMemberId: selectedMemberId
                ) { response in
                    DispatchQueue.main.async {
                        LoadingView.hideLoading()
                        if let response = response[self.homeWeekCalendarCollectionView.datePickedByOthers.replacingOccurrences(of: ".", with: "-")] {
                            self.pickDayWorkInfo = response
                            self.divideIndex = response.countLeft
                            self.workTotalNum = response.countLeft + response.countDone
                            self.pickDayWorkInfo?.houseWorks = self.listCompleteHouseWorkLast(WorkList: response.houseWorks ?? [HouseWorkData]())
                            if response.countDone + response.countLeft != 0 {
                                self.emptyHouseWorkImage.isHidden = true
                                self.calendarDailyTableView.isHidden = false
                            } else {
                                self.emptyHouseWorkImage.isHidden = false
                                self.calendarDailyTableView.isHidden = true
                            }
                            self.finishedWorkSum = response.countDone
                        }
                        self.bindWeekWorkDoneLable(isOwn: isOwn)
                    }
                }
            }
        }
    }
    
    private func getRules() {
        self.getRulesFromServer() { response in
            self.ruleArray = response.ruleResponseDtos
            self.setHomeRuleLabel()
        }
    }
    
    private func getTeamInfo() {
        self.getTeamInfoFromServer() { response in
            self.homeGroupLabel.text = response.teamName
            self.myId = response.members?.first?.memberId
            self.selectedMemberId = response.members?.first?.memberId
            self.teamId = response.teamId
            guard let userName = response.members?[0].memberName else { return }
            self.userName = userName
            self.nameTitleLabel.text = "\(userName)님"
            guard let teamMember = response.members else { return }
            self.homeGroupCollectionView.userList = teamMember
        }
    }
    
    private func bindWeekWorkDoneLable(isOwn: Bool) {
        guard let firstDateInFullDateList = self.homeWeekCalendarCollectionView.fullDateList.first else { return }
        guard let lastDateInFullDateList = self.homeWeekCalendarCollectionView.fullDateList.last else { return }
        var doneWorkSum: Int = 0
        DispatchQueue.global().async {
            if isOwn {
                self.getDateHouseWork(
                    fromDate: firstDateInFullDateList.replacingOccurrences(of: ".", with: "-"),
                    toDate: lastDateInFullDateList.replacingOccurrences(of: ".", with: "-")
                ) { response in
                    for date in self.homeWeekCalendarCollectionView.fullDateList {
                        guard let workDoneInWeek = response[date.replacingOccurrences(of: ".", with: "-")] else { return }
                        doneWorkSum = doneWorkSum + workDoneInWeek.countDone
                    }
                    self.countWorkDoneInWeek = doneWorkSum
                }
            } else {
                guard let selectedMemberId = self.selectedMemberId else { return }
                self.getMemberDateHouseWork(
                    fromDate: firstDateInFullDateList.replacingOccurrences(of: ".", with: "-"),
                    toDate: lastDateInFullDateList.replacingOccurrences(of: ".", with: "-"),
                    teamMemberId: selectedMemberId
                ) { response in
                    for date in self.homeWeekCalendarCollectionView.fullDateList {
                        guard let workDoneInWeek = response[date.replacingOccurrences(of: ".", with: "-")] else { return }
                        doneWorkSum = doneWorkSum + workDoneInWeek.countDone
                    }
                    self.countWorkDoneInWeek = doneWorkSum
                }
            }
        }
    }

    // MARK: - observer
    
    @objc func observeWeekCalendar(notification: Notification) {
        guard let object = notification.userInfo?[NotificationKey.date] as? String else { return }

        self.getHouseWorksByDate(
            isOwn: self.checkMemeberCellIsOwn(),
            startDate: object,
            endDate: object
        )
    }

    @objc func observeMemberCollectionView(notification: Notification) {
        self.userName = self.homeGroupCollectionView.selectedMemberName
        guard let object = notification.userInfo?[NotificationKey.member] as? Int else { return }
        
        self.selectedMemberId = object
        self.getHouseWorksByDate (
            isOwn: self.checkMemeberCellIsOwn(),
            startDate: Date().dateToString,
            endDate: Date().dateToString
        )
    }
    
    // MARK: - selector
    
    @objc
    private func addTapGesture() {
        // FIXME: - 집안일 추가 뷰로 연결
        print("tap")
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) { self.homeWeekCalendarCollectionView.getAfterWeekDate() }
        if (sender.direction == .right) { self.homeWeekCalendarCollectionView.getBeforeWeekDate() }
        self.getHouseWorksByDate(
            isOwn: self.checkMemeberCellIsOwn(),
            startDate: self.homeWeekCalendarCollectionView.fullDateList.first ?? String(),
            endDate: self.homeWeekCalendarCollectionView.fullDateList.first ?? String()
        )
    }
}

    // MARK: - extension

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0.1 {
            if isScrolled == false {
                scrollDidStart()
                isScrolled = true
            }
        }else {
            scrollDidEnd()
            isScrolled = false
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedCell = tableView.cellForRow(at: indexPath) as! CalendarDailyTableViewCell
        selectedCell.shadowLayer.layer.cornerRadius = 0
        if indexPath.section < self.divideIndex {
            selectedCell.shadowLayer.backgroundColor = .blue
            let swipeAction = UIContextualAction(style: .normal, title: "완료", handler: { action, view, completionHaldler in
                self.completeHouseWork(houseWorkId: selectedCell.houseWorkId, scheduledDate: selectedCell.scheduledDate) { response in
                    self.pickDayWorkInfo?.houseWorks?[indexPath.section].houseWorkCompleteId = response.houseWorkCompleteId ?? Int()
                }
                self.pickDayWorkInfo?.houseWorks?[indexPath.section].success = true
                self.finishedWorkSum = self.countDoneHouseWork(WorkList: self.pickDayWorkInfo?.houseWorks ?? [HouseWorkData]())
                let newHouseWorks = self.listCompleteHouseWorkLast(WorkList: self.pickDayWorkInfo?.houseWorks ?? [HouseWorkData]())
                self.pickDayWorkInfo?.houseWorks = newHouseWorks
                self.getDivideIndex()
                completionHaldler(true)
            })
            swipeAction.backgroundColor = .blue
            let configuration = UISwipeActionsConfiguration(actions: [swipeAction])
            return configuration
        }else {
            selectedCell.shadowLayer.backgroundColor = .gray400
            let swipeAction = UIContextualAction(style: .normal, title: "되돌리기", handler: { action, view, completionHaldler in
                self.deleteCompleteHouseWork(houseWorkCompleteId: selectedCell.houseWorkCompleteId)
                self.pickDayWorkInfo?.houseWorks?[indexPath.section].success = false
                self.finishedWorkSum = self.countDoneHouseWork(WorkList: self.pickDayWorkInfo?.houseWorks ?? [HouseWorkData]())
                let newHouseWorks = self.listCompleteHouseWorkLast(WorkList: self.pickDayWorkInfo?.houseWorks ?? [HouseWorkData]())
                self.pickDayWorkInfo?.houseWorks = newHouseWorks
                self.getDivideIndex()
                completionHaldler(true)
            })
            swipeAction.backgroundColor = .gray400
            let configuration = UISwipeActionsConfiguration(actions: [swipeAction])
            return configuration
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: - 집안일 수정 뷰로 이동
    }
}
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Int(self.pickDayWorkInfo?.countDone ?? 0) + Int(self.pickDayWorkInfo?.countLeft ?? 0)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.text = "끝낸 집안일 \(String(describing: self.finishedWorkSum))"
        header.font = .title2
        header.textColor = .black
        return section == self.divideIndex ? header : UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == self.divideIndex ? 68 : SizeLiteral.componentPadding
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = calendarDailyTableView.dequeueReusableCell(withIdentifier: CalendarDailyTableViewCell.identifier, for: indexPath) as? CalendarDailyTableViewCell ?? CalendarDailyTableViewCell()
        cell.selectionStyle = .none
        cell.workLabel.text = self.pickDayWorkInfo?.houseWorks?[indexPath.section].houseWorkName
        cell.room.text = self.pickDayWorkInfo?.houseWorks?[indexPath.section].space
        cell.time.text = self.pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledTime
        
        if self.pickDayWorkInfo?.houseWorks?[indexPath.section].success == false {
            cell.mainBackground.backgroundColor = .white
            cell.houseWorkId = self.pickDayWorkInfo?.houseWorks?[indexPath.section].houseWorkId ?? Int()
            cell.scheduledDate = self.pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledDate ?? String()
        }else {
            cell.mainBackground.backgroundColor = .positive10
            cell.houseWorkCompleteId = self.pickDayWorkInfo?.houseWorks?[indexPath.section].houseWorkCompleteId ?? Int()
        }
        cell.memberListProfilePath = self.pickDayWorkInfo?.houseWorks?[indexPath.section].assignees ?? [Assignee]()

        guard let pickDayHouseWork = self.pickDayWorkInfo?.houseWorks?[indexPath.section].space else { return cell }
        switch pickDayHouseWork {
        case "BATHROOM": cell.room.text = Space.bathroom.rawValue
        case "ENTRANCE": cell.room.text = Space.entrance.rawValue
        case "KITCHEN": cell.room.text = Space.kitchen.rawValue
        case "LIVINGROOM": cell.room.text = Space.livingRoom.rawValue
        case "OUTSIDE": cell.room.text = Space.outside.rawValue
        case "ROOM": cell.room.text = Space.room.rawValue
        case "ETC": cell.room.text = "기타"
        default: cell.room.text = ""
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SizeLiteral.homeViewWorkCellHeight
    }
}

    // MARK: - network

extension HomeViewController {
    
    func completeHouseWork(houseWorkId: Int, scheduledDate: String, completion: @escaping (HouseWorkCompleteResponse) -> Void) {
        NetworkService.shared.houseWorkCompleteRouter.completeHouseWork(houseWorkId: houseWorkId, scheduledDate: scheduledDate) { result in
            switch result {
            case .success(let response):
                guard let houseWorkCompleteId = response as? HouseWorkCompleteResponse else { return }
                self.bindWeekWorkDoneLable(isOwn: true)
                completion(houseWorkCompleteId)
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                print("error")
            }
        }
    }
    
    func deleteCompleteHouseWork(houseWorkCompleteId: Int) {
        NetworkService.shared.houseWorkCompleteRouter.deleteCompleteHouseWork(houseWorkCompleteId: houseWorkCompleteId) { result in
            switch result {
            case .success:
                self.bindWeekWorkDoneLable(isOwn: true)
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                print("error")
            }
        }
    }
    
    func getDateHouseWork(fromDate: String, toDate: String, completion: @escaping (WorkInfoReponse) -> Void) {
        NetworkService.shared.houseWorks.getHouseWorksByDate(fromDate: fromDate, toDate: toDate) { result in
            switch result {
            case .success(let response):
                guard let houseWorkResponse = response as? WorkInfoReponse else { return }
                completion(houseWorkResponse)
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                print("error")
            }
        }
    }
    
    func getMemberDateHouseWork(fromDate: String, toDate: String, teamMemberId: Int, completion: @escaping (WorkInfoReponse) -> Void) {
        NetworkService.shared.houseWorks.getMemberHouseWorksByDate(fromDate: fromDate, toDate: toDate, teamMemberId: teamMemberId) { result in
            switch result {
            case .success(let response):
                guard let memberHouseWorkResponse = response as? WorkInfoReponse else { return }
                completion(memberHouseWorkResponse)
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                print("error")
            }
        }
    }
    
    func getRulesFromServer(completion: @escaping (RulesResponse) -> Void) {
        NetworkService.shared.rules.getRules() { result in
            switch result {
            case .success(let response):
                guard let rules = response as? RulesResponse else { return }
                completion(rules)
            case .requestErr(let errResponse):
                dump(errResponse)
            default:
                print("error")
            }
        }
    }
    
    func getTeamInfoFromServer(completion: @escaping (TeamInfoResponse) -> Void) {
        NetworkService.shared.teams.getTeamInfo() { result in
            switch result {
            case .success(let response):
                guard let team = response as? TeamInfoResponse else { return }
                completion(team)
            case .requestErr(let errResponse):
                dump(errResponse)
            default:
                print("error")
            }
        }
    }
}
