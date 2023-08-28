//
//  HomeViewController.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class HomeViewController: BaseViewController {
    
    // MARK: - property
    
    private var teamId: Int?
    private var ruleArray: [RuleData] = [] {
        didSet {
            self.ruleArrayIndex = 0
        }
    }
    private var ruleArrayIndex = 0
    private var isScrolled = false
    private var reloadHouseWork = false
    private lazy var leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    private lazy var rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    private var selectedMemberId: Int?
    private var myId: Int?
    private lazy var divideIndex: Int = 0
    private lazy var workTotalNum: Int = 0
    private lazy var notFinishedWorkSum: Int = 0 {
        didSet {
            homeView.homeWeekCalendarCollectionView.countWorkLeft = String(notFinishedWorkSum)
        }
    }
    private lazy var finishedWorkSum: Int = 0
    private lazy var userName: String = String() {
        didSet {
            homeView.nameTitleLabel.text = "\(userName)님"
            if let text = homeView.nameTitleLabel.text {
                let attributeString = NSMutableAttributedString(string: text)
                attributeString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text as NSString).range(of: "\(userName)"))
                homeView.nameTitleLabel.attributedText = attributeString
            }
        }
    }
    private var pickDayWorkInfo: DayHouseWorks? {
        didSet {
            homeView.calendarDailyTableView.reloadData()
        }
    }
    private var countWorkDoneInWeek: Int? {
        didSet {
            guard let countWorkDoneInWeek = countWorkDoneInWeek else { return }
            guard let lastDateInFullDateList = homeView.homeWeekCalendarCollectionView.fullDateList.last?.stringToDate else { return }
            guard let finalLastDateInFullDateList = Calendar.current.date(byAdding: .day, value: 1, to: lastDateInFullDateList) else { return }
            if countWorkDoneInWeek == 0 {
                homeView.countDoneTitleLabel.text = TextLiteral.homeViewDefaultCountDoneTitleLabel
            } else if Date().dateCompare(fromDate: finalLastDateInFullDateList) == "Past" {
                homeView.countDoneTitleLabel.text = "저번주에 \(countWorkDoneInWeek)개나 해주셨어요!"
            } else {
                homeView.countDoneTitleLabel.text = "이번주에 \(countWorkDoneInWeek)개나 해주셨어요!"
            }
            if let text = homeView.countDoneTitleLabel.text {
                let attributeString = NSMutableAttributedString(string: text)
                attributeString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text as NSString).range(of: "\(String(countWorkDoneInWeek))개"))
                homeView.countDoneTitleLabel.attributedText = attributeString
            }
        }
    }
    private let homeView = HomeView()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setWeekCalendarSwipeGesture()
        setDatePicker()
        setButtonEvent()
        setHomeRuleLabel()
        setTitleLabelColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDivideIndex()
        self.getRules()
        self.getMyInfo()
        self.setNotification()
        
        if let myId = self.myId {
            self.selectedMemberId = myId
            self.homeView.homeGroupCollectionView.selectedIndex = 0
        }
        reloadHouseWork = true
    }
    
    override func viewDidLayoutSubviews() {
        if reloadHouseWork {
            let pickedDate = homeView.homeWeekCalendarCollectionView.datePickedByOthers.isEmpty ? homeView.homeWeekCalendarCollectionView.todayDateInString : homeView.homeWeekCalendarCollectionView.datePickedByOthers
            self.getHouseWorksByDate(
                startDate: pickedDate,
                endDate: pickedDate
            )
            self.getHouseWorksByWeek()
        }
    }
    
    override func configUI() {
        super.configUI()
        setupToolBarGesture()
    }
    
    override func render() {
        self.view = homeView
    }
    
    //MARK: - set up view
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let logoView = makeBarButtonItem(with: homeView.logoImage)
        let rightButton = makeBarButtonItem(with: homeView.profileButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = logoView
        navigationItem.rightBarButtonItem = rightButton
    }
    
    override func setupNavigationPopGesture() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func setupAlphaNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let logoView = makeBarButtonItem(with: homeView.logoImage)
        let rightButton = makeBarButtonItem(with: homeView.profileButton)
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
        homeView.calendarDailyTableView.delegate = self
        homeView.calendarDailyTableView.dataSource = self
    }
    
    private func setupToolBarGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addTapGesture))
        let tapRuleGesture = UITapGestureRecognizer(target: self, action: #selector(moveToSettingHomeRuleView))
        homeView.toolBarView.addGestureRecognizer(tapGesture)
        homeView.homeRuleView.addGestureRecognizer(tapRuleGesture)
    }
    
    @objc
    private func addTapGesture() {
        reloadHouseWork = false
        let selectHouseWorkView = SelectHouseWorkViewController()
        self.navigationController?.pushViewController(selectHouseWorkView, animated: true)
    }
    
    @objc
    private func moveToSettingHomeRuleView() {
        reloadHouseWork = false
        let settingHomeRuleView = SettingHomeRuleViewController()
        self.navigationController?.pushViewController(settingHomeRuleView, animated: true)
    }
    
    private func setTitleLabelColor() {
        homeView.nameTitleLabel.applyColor(to: userName, with: .blue)
        homeView.countDoneTitleLabel.applyColor(to: userName, with: .blue)
    }
    
    private func setHomeRuleLabel() {
        homeView.homeRuleView.homeRuleDescriptionLabel.text = ruleArray.isEmpty ? TextLiteral.homeRuleViewRuleDescriptionLabel : ruleArray[self.ruleArrayIndex].ruleName
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.ruleArray.isEmpty {
                self.homeView.homeRuleView.homeRuleDescriptionLabel.text = TextLiteral.homeRuleViewRuleDescriptionLabel
            } else {
                self.homeView.homeRuleView.homeRuleDescriptionLabel.text = self.ruleArray[self.ruleArrayIndex].ruleName
                self.ruleArrayIndex += 1
                if self.ruleArrayIndex > self.ruleArray.count - 1 {
                    self.ruleArrayIndex = 0
                }
            }
        }
    }
}

// MARK: - scroll extension

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        reloadHouseWork = false
        if scrollView.contentOffset.y > 2 {
            if !isScrolled {
                scrollDidStart()
                isScrolled = true
            }
        } else if scrollView.contentOffset.y < 0 {
            scrollDidEnd()
            isScrolled = false
        }
    }
}

// MARK: - table delegate extension

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !checkMemberCellIsOwn() { return nil }
        let selectedCell = tableView.cellForRow(at: indexPath) as! CalendarDailyTableViewCell
        selectedCell.shadowLayer.layer.cornerRadius = 0
        
        let swipeState = indexPath.section < self.divideIndex
        selectedCell.shadowLayer.backgroundColor = swipeState ? .blue : .gray400
        let swipeAction = UIContextualAction(style: .normal, title: swipeState ? "완료" : "되돌리기", handler: { action, view, completionHandler in
            swipeState ? self.completeHouseWork(houseWorkId: selectedCell.houseWorkId, scheduledDate: selectedCell.scheduledDate) { response in
                self.pickDayWorkInfo?.houseWorks?[indexPath.section].houseWorkCompleteId = response.houseWorkCompleteId ?? Int()
            } : self.deleteCompleteHouseWork(houseWorkCompleteId: selectedCell.houseWorkCompleteId)
            self.pickDayWorkInfo?.houseWorks?[indexPath.section].success = swipeState
            self.finishedWorkSum = self.countDoneHouseWork(workList: self.pickDayWorkInfo?.houseWorks ?? [HouseWorkData]())
            let newHouseWorks = self.listCompleteHouseWorkLast(workList: self.pickDayWorkInfo?.houseWorks ?? [HouseWorkData]())
            self.pickDayWorkInfo?.houseWorks = newHouseWorks
            self.getDivideIndex()
            completionHandler(true)
        })
        swipeAction.backgroundColor = swipeState ? .blue : .gray400
        let configuration = UISwipeActionsConfiguration(actions: [swipeAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !checkMemberCellIsOwn() { return }
        reloadHouseWork = false
        guard let selectedHouseWorkId = pickDayWorkInfo?.houseWorks?[indexPath.section].houseWorkId else { return }
        guard let selectedHouseWorkDate = pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledDate else { return }
        let editHouseWorkView = EditHouseWorkViewController(houseWorkId: selectedHouseWorkId, houseWorkDate: selectedHouseWorkDate)
        self.navigationController?.pushViewController(editHouseWorkView, animated: true)
    }
}

// MARK: - table dataSource extension

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
        let cell = homeView.calendarDailyTableView.dequeueReusableCell(withIdentifier: CalendarDailyTableViewCell.identifier, for: indexPath) as? CalendarDailyTableViewCell ?? CalendarDailyTableViewCell()
        cell.selectionStyle = .none
        cell.workLabel.text = self.pickDayWorkInfo?.houseWorks?[indexPath.section].houseWorkName
        cell.room.text = self.pickDayWorkInfo?.houseWorks?[indexPath.section].space
        cell.time.text = self.pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledTime ?? "하루종일"
        if self.pickDayWorkInfo?.houseWorks?[indexPath.section].success == false {
            cell.houseWorkId = self.pickDayWorkInfo?.houseWorks?[indexPath.section].houseWorkId ?? Int()
            cell.scheduledDate = self.pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledDate ?? String()
            let cellScheduledDate: Date = pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledDate?.stringToDate ?? Date()
            let strDateMessage: String = Date().dateCompare(fromDate: cellScheduledDate)
            switch strDateMessage {
            case "Future":
                cell.errorImage.isHidden = true
                cell.mainBackground.backgroundColor = .white
            case "Past":
                cell.errorImage.isHidden = false
                cell.setErrorImageView()
                cell.mainBackground.backgroundColor = .negative0
                cell.mainBackground.layer.borderColor = UIColor.negative10.cgColor
            case "Same":
                if compareTime(inputTime: self.pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledTime ?? String()) == "notOver" {
                    cell.errorImage.isHidden = true
                    cell.mainBackground.backgroundColor = .white
                } else {
                    cell.errorImage.isHidden = false
                    cell.setErrorImageView()
                    cell.mainBackground.backgroundColor = .negative0
                    cell.mainBackground.layer.borderColor = UIColor.negative10.cgColor
                }
            default: return cell
            }
        } else {
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

// MARK: - network func extension

private extension HomeViewController {
    func getHouseWorksByDate(startDate: String, endDate: String) {
        guard let myId = self.myId else { return }
        guard let selectedMemberId = self.selectedMemberId else { return }
        self.getMemberDateHouseWork(
            fromDate: startDate.replacingOccurrences(of: ".", with: "-"),
            toDate: endDate.replacingOccurrences(of: ".", with: "-"),
            teamMemberId: checkMemberCellIsOwn() ? myId : selectedMemberId
        ) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let response = response[self.homeView.homeWeekCalendarCollectionView.datePickedByOthers.replacingOccurrences(of: ".", with: "-")] {
                    self.pickDayWorkInfo = response
                    self.divideIndex = response.countLeft
                    self.workTotalNum = response.countLeft + response.countDone
                    self.pickDayWorkInfo?.houseWorks = self.listCompleteHouseWorkLast(workList: response.houseWorks ?? [HouseWorkData]())
                    self.homeView.emptyHouseWorkImage.isHidden = self.workTotalNum != 0
                    self.homeView.calendarDailyTableView.isHidden = self.workTotalNum == 0
                    self.finishedWorkSum = response.countDone
                    self.notFinishedWorkSum = self.workTotalNum - self.finishedWorkSum
                }
            }
        }
    }
    
    func getRules() {
        self.getRulesFromServer() { [weak self] response in
            guard let self = self else { return }
            self.ruleArray = response.ruleResponseDtos ?? []
            self.setHomeRuleLabelAfterSettingRules()
        }
    }
    
    func setHomeRuleLabelAfterSettingRules() {
        homeView.homeRuleView.homeRuleDescriptionLabel.text = ruleArray.isEmpty ? TextLiteral.homeRuleViewRuleDescriptionLabel : ruleArray[self.ruleArrayIndex].ruleName
    }
    
    func getMyInfo() {
        self.getMyInfoFromServer { [weak self] response in
            guard let self = self else { return }
            self.myId = response.memberId
            self.getTeamInfo()
        }
    }
    
    func getTeamInfo() {
        self.getTeamInfoFromServer() { [weak self] response in
            guard let self = self else { return }
            self.homeView.homeGroupLabel.text = (response.teamName ?? "") + " " +  String(response.members?.count ?? 0)
            self.selectedMemberId = self.myId
            self.teamId = response.teamId
            self.homeView.homeGroupCollectionView.userList = []
            if let teamMember = response.members {
                let sortedTeamMember = teamMember.sorted { $0.memberName ?? "" < $1.memberName ?? "" }
                for member in sortedTeamMember {
                    if self.myId == member.memberId {
                        self.homeView.homeGroupCollectionView.userList.insert(member, at: 0)
                        self.userName = member.memberName ?? ""
                    } else {
                        self.homeView.homeGroupCollectionView.userList.append(member)
                    }
                }
            }
        }
    }
    
    func getHouseWorksByWeek() {
        guard let firstDateInFullDateList = homeView.homeWeekCalendarCollectionView.fullDateList.first else { return }
        guard let lastDateInFullDateList = homeView.homeWeekCalendarCollectionView.fullDateList.last else { return }
        var doneWorkSum: Int = 0
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
        }
        guard let myId = myId else { return }
        guard let selectedMemberId = selectedMemberId else { return }
        self.getMemberDateHouseWork(
            fromDate: firstDateInFullDateList.replacingOccurrences(of: ".", with: "-"),
            toDate: lastDateInFullDateList.replacingOccurrences(of: ".", with: "-"),
            teamMemberId: checkMemberCellIsOwn() ? myId : selectedMemberId
        ) { [weak self] response in
            guard let self = self else { return }
            self.view.isUserInteractionEnabled = true
            self.homeView.homeWeekCalendarCollectionView.countWorkLeftWeekCalendar = [Int]()
            self.homeView.homeWeekCalendarCollectionView.dotList = [UIImage]()
            for date in self.homeView.homeWeekCalendarCollectionView.fullDateList {
                if let workDate = response[date.replacingOccurrences(of: ".", with: "-")] {
                    self.homeView.homeWeekCalendarCollectionView.countWorkLeftWeekCalendar?.append(workDate.countLeft)
                    doneWorkSum += workDate.countDone
                    switch workDate.countLeft {
                    case 0:
                        self.homeView.homeWeekCalendarCollectionView.dotList.append(UIImage())
                    case 1...3:
                        self.homeView.homeWeekCalendarCollectionView.dotList.append(ImageLiterals.oneDot)
                    case 4...6:
                        self.homeView.homeWeekCalendarCollectionView.dotList.append(ImageLiterals.twoDots)
                    default:
                        self.homeView.homeWeekCalendarCollectionView.dotList.append(ImageLiterals.threeDots)
                    }
                }
            }
            if self.checkMemberCellIsOwn() { self.countWorkDoneInWeek = doneWorkSum }
            self.homeView.calendarDailyTableView.reloadData()
        }
    }
    
    func completeHouseWork(houseWorkId: Int, scheduledDate: String, completion: @escaping (HouseWorkCompleteResponse) -> Void) {
        NetworkService.shared.houseWorkCompleteRouter.completeHouseWork(houseWorkId: houseWorkId, scheduledDate: scheduledDate) { result in
            switch result {
            case .success(let response):
                guard let houseWorkCompleteId = response as? HouseWorkCompleteResponse else { return }
                self.getHouseWorksByWeek()
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
                self.getHouseWorksByWeek()
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
    
    func getMyInfoFromServer(completion: @escaping (MemberResponse) -> Void) {
        NetworkService.shared.members.getMemberInfo() { result in
            switch result {
            case .success(let response):
                guard let myInfo = response as? MemberResponse else { return }
                completion(myInfo)
            case .requestErr(let errResponse):
                dump(errResponse)
            default:
                print("error")
            }
        }
    }
}

// MARK: - set button action extension

private extension HomeViewController {
    func setButtonEvent() {
        homeView.datePickerView.setAction()
        let moveToTodayDateButtonAction = UIAction { [weak self] _ in
            self?.scrollDidEnd()
            self?.isScrolled = false
            self?.moveToTodayDate()
        }
        let moveToTodayDatePickerButtonAction = UIAction { [weak self] _ in
            self?.scrollDidEnd()
            self?.isScrolled = false
            self?.reloadHouseWork = false
            self?.moveToDatePicker()
        }
        let moveToSettingViewAction = UIAction { [weak self] _ in
            self?.reloadHouseWork = false
            self?.moveToSettingView()
        }
        
        homeView.homeCalenderView.todayButton.addAction(moveToTodayDateButtonAction, for: .touchUpInside)
        homeView.homeCalenderView.calendarMonthLabelButton.addAction(moveToTodayDatePickerButtonAction, for: .touchUpInside)
        homeView.homeCalenderView.calendarMonthPickButton.addAction(moveToTodayDatePickerButtonAction, for: .touchUpInside)
        homeView.profileButton.addAction(moveToSettingViewAction, for: .touchUpInside)
    }
    
    func moveToTodayDate() {
        homeView.homeCalenderView.calendarMonthLabelButton.setTitle("\(Date().yearToString)년 \(Date().monthToString)월", for: .normal)
        homeView.homeWeekCalendarCollectionView.startOfWeekDate = Date().startOfWeek
        homeView.homeWeekCalendarCollectionView.datePickedByOthers = Date().dateToString
        homeView.homeWeekCalendarCollectionView.fullDateList = homeView.homeWeekCalendarCollectionView.getThisWeekInDate()
        self.getHouseWorksByWeek()
        self.getHouseWorksByDate(
            startDate: homeView.homeWeekCalendarCollectionView.datePickedByOthers,
            endDate: homeView.homeWeekCalendarCollectionView.datePickedByOthers
        )
    }
    
    func moveToDatePicker() {
        if !homeView.homeWeekCalendarCollectionView.datePickedByOthers.isEmpty {
            homeView.datePickerView.datePicker.setDate(homeView.homeWeekCalendarCollectionView.datePickedByOthers.stringToDate ?? Date(), animated: false)
        }
        homeView.datePickerView.isHidden = false
        homeView.bringSubviewToFront(homeView.datePickerView)
        self.setupAlphaNavigationBar()
    }
    
    func moveToSettingView() {
        let settingView = SettingViewController()
        self.navigationController?.pushViewController(settingView, animated: true)
    }
}

// MARK: - set calander & memeber collection extension

private extension HomeViewController {
    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(observeWeekCalendar(notification:)), name: Notification.Name.date, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observeMemberCollectionView(notification:)), name: Notification.Name.member, object: nil)
    }
    
    func setWeekCalendarSwipeGesture() {
        leftSwipeGestureRecognizer.direction = .left
        rightSwipeGestureRecognizer.direction = .right
        homeView.homeWeekCalendarCollectionView.addGestureRecognizer(leftSwipeGestureRecognizer)
        homeView.homeWeekCalendarCollectionView.addGestureRecognizer(rightSwipeGestureRecognizer)
    }
    
    func setDatePicker() {
        homeView.datePickerView.isHidden = true
        homeView.datePickerView.dismissClosure = { [weak self] pickedDate, startDateWeek, yearInString, monthInString in
            guard let self = self else { return }
            self.homeView.homeWeekCalendarCollectionView.startOfWeekDate = startDateWeek
            self.homeView.homeWeekCalendarCollectionView.datePickedByOthers = pickedDate.dateToString
            self.homeView.homeWeekCalendarCollectionView.fullDateList = self.homeView.homeWeekCalendarCollectionView.getThisWeekInDate()
            self.homeView.homeCalenderView.calendarMonthLabelButton.setTitle("\(yearInString)년 \(monthInString)월", for: .normal)
            self.homeView.datePickerView.isHidden = true
            self.getHouseWorksByDate(
                startDate: pickedDate.dateToString,
                endDate: pickedDate.dateToString
            )
            self.getHouseWorksByWeek()
            self.setupNavigationBar()
        }
        homeView.datePickerView.changeClosure = { [weak self] val in
            guard self != nil else {
                return
            }
        }
        homeView.homeWeekCalendarCollectionView.yearMonthDateByTouchedCell = { [weak self] yearDate in
            guard let self = self else { return }
            let seporateResult = yearDate.components(separatedBy: ".")
            self.homeView.homeCalenderView.calendarMonthLabelButton.setTitle("\(seporateResult[0])년 \(seporateResult[1])월", for: .normal)
        }
    }
    
    @objc func observeWeekCalendar(notification: Notification) {
        guard let object = notification.userInfo?[NotificationKey.date] as? String else { return }
        let dateArray = object.split(separator: ".")
        self.scrollDidEnd()
        self.isScrolled = false
        homeView.homeCalenderView.calendarMonthLabelButton.setTitle("\(dateArray[0])년 \(dateArray[1])월", for: .normal)
        self.getHouseWorksByDate (
            startDate: object,
            endDate: object
        )
    }
    
    @objc func observeMemberCollectionView(notification: Notification) {
        guard let object = notification.userInfo?[NotificationKey.member] as? Int else { return }
        self.selectedMemberId = object
        let pickedDate = homeView.homeWeekCalendarCollectionView.datePickedByOthers.isEmpty ? Date().dateToString : homeView.homeWeekCalendarCollectionView.datePickedByOthers
        DispatchQueue.main.async {
            self.getHouseWorksByDate (
                startDate: pickedDate,
                endDate: pickedDate
            )
            self.getHouseWorksByWeek()
        }
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        self.scrollDidEnd()
        isScrolled = false
        if sender.direction == .left {
            homeView.homeWeekCalendarCollectionView.getAfterWeekDate()
        }
        if sender.direction == .right {
            homeView.homeWeekCalendarCollectionView.getBeforeWeekDate()
        }
        self.getHouseWorksByDate(
            startDate: homeView.homeWeekCalendarCollectionView.fullDateList.first ?? String(),
            endDate: homeView.homeWeekCalendarCollectionView.fullDateList.first ?? String()
        )
        self.getHouseWorksByWeek()
    }
}

// MARK: - calendarDailyTableView func extension

private extension HomeViewController {
    func getDivideIndex() {
        self.divideIndex = 0
        
        for divider in self.pickDayWorkInfo?.houseWorks ?? [HouseWorkData]() {
            if divider.success { continue }
            self.divideIndex = self.divideIndex + 1
        }
    }
    
    func listCompleteHouseWorkLast(workList: [HouseWorkData]) -> [HouseWorkData] {
        var unfinishedList = [HouseWorkData]()
        var finishedList = [HouseWorkData]()
        
        for work in workList {
            if work.success { finishedList.append(work) }
            else { unfinishedList.append(work) }
        }
        return unfinishedList + finishedList
    }
    
    func countDoneHouseWork(workList: [HouseWorkData]) -> Int {
        var finishedHouseWorkNum = 0
        workList.forEach { if $0.success { finishedHouseWorkNum += 1 } }
        return finishedHouseWorkNum
    }
    
    func scrollDidStart(){
        homeView.homeRuleView.homeRuleLabel.isHidden = true
        homeView.homeRuleView.homeRuleDescriptionLabel.isHidden = true
        homeView.homeGroupCollectionView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        homeView.homeRuleView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        homeView.homeDivider.snp.updateConstraints {
            $0.top.equalTo(homeView.homeGroupLabel.snp.bottom).offset(16)
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func scrollDidEnd() {
        homeView.homeDivider.snp.updateConstraints {
            $0.top.equalTo(homeView.homeGroupLabel.snp.bottom).offset(144)
        }
        homeView.homeGroupCollectionView.snp.updateConstraints {
            $0.height.equalTo(70)
        }
        homeView.homeRuleView.snp.updateConstraints {
            $0.height.equalTo(35)
        }
        homeView.homeRuleView.homeRuleLabel.isHidden = false
        homeView.homeRuleView.homeRuleDescriptionLabel.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func checkMemberCellIsOwn() -> Bool {
        return myId == selectedMemberId
    }
    
    func compareTime(inputTime: String) -> String {
        if inputTime.isEmpty { return "notOver" }
        let currentTime = Date().dateToTimeString
        let currentTimeInInt = Int(currentTime.components(separatedBy: [":"]).joined()) ?? Int()
        let inputTimeInInt = Int(inputTime.components(separatedBy: [":"]).joined()) ?? Int()
        return currentTimeInInt < inputTimeInInt ? "notOver" : "over"
    }
}
