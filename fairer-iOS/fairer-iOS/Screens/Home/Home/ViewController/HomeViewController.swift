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
    private var ruleArray: [RuleData]? {
        didSet {
            self.ruleArrayIndex = 0
        }
    }
    private var ruleArrayIndex = 0
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
            notFinishedWorkSum = workTotalNum - finishedWorkSum
            homewView.homeWeekCalendarCollectionView.countWorkLeft = String(notFinishedWorkSum)
        }
    }
    private lazy var userName: String = String() {
        didSet {
            homewView.nameTitleLabel.text = "\(userName)님"
            if let text = homewView.nameTitleLabel.text {
                let attributeString = NSMutableAttributedString(string: text)
                attributeString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text as NSString).range(of: "\(userName)"))
                homewView.nameTitleLabel.attributedText = attributeString
            }
        }
    }
    private var pickDayWorkInfo: DayHouseWorks? {
        didSet {
            homewView.calendarDailyTableView.reloadData()
        }
    }
    private var countWorkDoneInWeek: Int? {
        didSet {
            guard let countWorkDoneInWeek = countWorkDoneInWeek else { return }
            guard let lastDateInFullDateList = homewView.homeWeekCalendarCollectionView.fullDateList.last?.stringToDate else { return }
            guard let finalLastDateInFullDateList = Calendar.current.date(byAdding: .day, value: 1, to: lastDateInFullDateList) else { return }
            if countWorkDoneInWeek == 0 {
                homewView.countDoneTitleLabel.text = TextLiteral.homeViewDefaultCountDoneTitleLabel
            } else if Date().dateCompare(fromDate: finalLastDateInFullDateList) == "Past" {
                homewView.countDoneTitleLabel.text = "저번주에 \(countWorkDoneInWeek)개나 해주셨어요!"
                if let text = homewView.countDoneTitleLabel.text {
                    let attributeString = NSMutableAttributedString(string: text)
                    attributeString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text as NSString).range(of: "\(String(countWorkDoneInWeek))개"))
                    homewView.countDoneTitleLabel.attributedText = attributeString
                }
            } else {
                homewView.countDoneTitleLabel.text = "이번주에 \(countWorkDoneInWeek)개나 해주셨어요!"
                if let text = homewView.countDoneTitleLabel.text {
                    let attributeString = NSMutableAttributedString(string: text)
                    attributeString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text as NSString).range(of: "\(String(countWorkDoneInWeek))개"))
                    homewView.countDoneTitleLabel.attributedText = attributeString
                }
            }
        }
    }
    private let homewView = HomeView()
    
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
        if homewView.homeWeekCalendarCollectionView.datePickedByOthers == "" {
            self.getHouseWorksByDate(
                isOwn: self.checkMemeberCellIsOwn(),
                startDate: homewView.homeWeekCalendarCollectionView.todayDateInString,
                endDate: homewView.homeWeekCalendarCollectionView.todayDateInString
            )
        } else {
            self.getHouseWorksByDate(
                isOwn: self.checkMemeberCellIsOwn(),
                startDate: homewView.homeWeekCalendarCollectionView.datePickedByOthers,
                endDate: homewView.homeWeekCalendarCollectionView.datePickedByOthers
            )
        }
        self.getRules()
        self.getMyInfo()
        self.setNotification()
    }
    
    override func configUI() {
        super.configUI()
        setupToolBarGesture()
    }
    
    override func render() {
        self.view = homewView
    }
    
    //MARK: - set up view
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let logoView = makeBarButtonItem(with: homewView.logoImage)
        let rightButton = makeBarButtonItem(with: homewView.profileButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = logoView
        navigationItem.rightBarButtonItem = rightButton
    }
    
    override func setupNavigationPopGesture() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func setupAlphaNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let logoView = makeBarButtonItem(with: homewView.logoImage)
        let rightButton = makeBarButtonItem(with: homewView.profileButton)
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
        homewView.calendarDailyTableView.delegate = self
        homewView.calendarDailyTableView.dataSource = self
    }
    
    private func setupToolBarGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addTapGesture))
        let tapRuleGesture = UITapGestureRecognizer(target: self, action: #selector(moveToSettingHomeRuleView))
        homewView.toolBarView.addGestureRecognizer(tapGesture)
        homewView.homeRuleView.addGestureRecognizer(tapRuleGesture)
    }
    
    @objc
    private func addTapGesture() {
        let selectHouseWorkView = SelectHouseWorkViewController()
        self.navigationController?.pushViewController(selectHouseWorkView, animated: true)
    }
    
    @objc
    private func moveToSettingHomeRuleView() {
        let settingHomeRuleView = SettingHomeRuleViewController()
        self.navigationController?.pushViewController(settingHomeRuleView, animated: true)
    }
    
    private func setTitleLabelColor() {
        homewView.nameTitleLabel.applyColor(to: userName, with: .blue)
        homewView.countDoneTitleLabel.applyColor(to: userName, with: .blue)
    }
    
    private func setHomeRuleLabel() {
        if ruleArray?.isEmpty == true {
            homewView.homeRuleView.homeRuleDescriptionLabel.text = TextLiteral.homeRuleViewRuleDescriptionLabel
        } else {
            homewView.homeRuleView.homeRuleDescriptionLabel.text = ruleArray?[self.ruleArrayIndex].ruleName
        }
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            guard let count = self?.ruleArray?.count else { return }
            if self?.ruleArray?.isEmpty == true {
                self?.homewView.homeRuleView.homeRuleDescriptionLabel.text = TextLiteral.homeRuleViewRuleDescriptionLabel
            } else {
                self?.homewView.homeRuleView.homeRuleDescriptionLabel.text = self?.ruleArray?[self?.ruleArrayIndex ?? Int()].ruleName
                self?.ruleArrayIndex += 1
                if self?.ruleArrayIndex ?? Int() > count - 1 {
                    self?.ruleArrayIndex = 0
                }
            }
        }
    }
}

// MARK: - scroll extension

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 2 {
            if isScrolled == false {
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
        } else {
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
        // MARK: - fix me, houseWorks 빈 배열 대체
        let editHouseWorkView = EditHouseWorkViewController(editHouseWork: EditHouseWorkRequest())
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
        let cell = homewView.calendarDailyTableView.dequeueReusableCell(withIdentifier: CalendarDailyTableViewCell.identifier, for: indexPath) as? CalendarDailyTableViewCell ?? CalendarDailyTableViewCell()
        cell.selectionStyle = .none
        cell.workLabel.text = self.pickDayWorkInfo?.houseWorks?[indexPath.section].houseWorkName
        cell.room.text = self.pickDayWorkInfo?.houseWorks?[indexPath.section].space
        cell.time.text = self.pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledTime
        
        if self.pickDayWorkInfo?.houseWorks?[indexPath.section].success == false {
            cell.houseWorkId = self.pickDayWorkInfo?.houseWorks?[indexPath.section].houseWorkId ?? Int()
            cell.scheduledDate = self.pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledDate ?? String()
            if Date().dateCompare(fromDate: self.pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledDate?.stringToDate ?? Date()) == "Future" {
                cell.errorImage.isHidden = true
                cell.mainBackground.backgroundColor = .white
            } else if compareTime(inputTime: self.pickDayWorkInfo?.houseWorks?[indexPath.section].scheduledTime ?? String()) == "notOver" {
                cell.errorImage.isHidden = true
                cell.mainBackground.backgroundColor = .white
            } else {
                cell.errorImage.isHidden = false
                cell.setErrorImageView()
                cell.mainBackground.backgroundColor = .negative0
                cell.mainBackground.layer.borderColor = UIColor.negative10.cgColor
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
    func getHouseWorksByDate(isOwn: Bool, startDate: String, endDate: String) {
        DispatchQueue.main.async {
            LoadingView.showLoading()
        }
        DispatchQueue.global().async {
            if isOwn {
                self.getDateHouseWork(
                    fromDate: startDate.replacingOccurrences(of: ".", with: "-"),
                    toDate: endDate.replacingOccurrences(of: ".", with: "-")
                ) { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        LoadingView.hideLoading()
                        if let response = response[self.homewView.homeWeekCalendarCollectionView.datePickedByOthers.replacingOccurrences(of: ".", with: "-")] {
                            self.pickDayWorkInfo = response
                            self.divideIndex = response.countLeft
                            self.workTotalNum = response.countLeft + response.countDone
                            self.pickDayWorkInfo?.houseWorks = self.listCompleteHouseWorkLast(WorkList: response.houseWorks ?? [HouseWorkData]())
                            if response.countDone + response.countLeft != 0 {
                                self.homewView.emptyHouseWorkImage.isHidden = true
                                self.homewView.calendarDailyTableView.isHidden = false
                            } else {
                                self.homewView.emptyHouseWorkImage.isHidden = false
                                self.homewView.calendarDailyTableView.isHidden = true
                            }
                            self.finishedWorkSum = response.countDone
                        }
                        self.homewView.calendarDailyTableView.reloadData()
                    }
                    DispatchQueue.global().async {
                        self.getHouseWorksByWeek(isOwn: isOwn)
                    }
                }
            } else {
                guard let selectedMemberId = self.selectedMemberId else { return }
                self.getMemberDateHouseWork(
                    fromDate: startDate.replacingOccurrences(of: ".", with: "-"),
                    toDate: endDate.replacingOccurrences(of: ".", with: "-"),
                    teamMemberId: selectedMemberId
                ) { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        LoadingView.hideLoading()
                        if let response = response[self.homewView.homeWeekCalendarCollectionView.datePickedByOthers.replacingOccurrences(of: ".", with: "-")] {
                            self.pickDayWorkInfo = response
                            self.divideIndex = response.countLeft
                            self.workTotalNum = response.countLeft + response.countDone
                            self.pickDayWorkInfo?.houseWorks = self.listCompleteHouseWorkLast(WorkList: response.houseWorks ?? [HouseWorkData]())
                            if response.countDone + response.countLeft != 0 {
                                self.homewView.emptyHouseWorkImage.isHidden = true
                                self.homewView.calendarDailyTableView.isHidden = false
                            } else {
                                self.homewView.emptyHouseWorkImage.isHidden = false
                                self.homewView.calendarDailyTableView.isHidden = true
                            }
                            self.finishedWorkSum = response.countDone
                        }
                    }
                    DispatchQueue.global().async {
                        self.getHouseWorksByWeek(isOwn: isOwn)
                    }
                }
            }
        }
    }
    
    func getRules() {
        self.getRulesFromServer() { [weak self] response in
            guard let self = self else {
                return
            }
            self.ruleArray = response.ruleResponseDtos
            self.setHomeRuleLableAfterSettingRules()
        }
    }
    
    func setHomeRuleLableAfterSettingRules() {
        if ruleArray?.isEmpty == true {
            homewView.homeRuleView.homeRuleDescriptionLabel.text = TextLiteral.homeRuleViewRuleDescriptionLabel
        } else {
            homewView.homeRuleView.homeRuleDescriptionLabel.text = ruleArray?[self.ruleArrayIndex].ruleName
        }
    }
    
    func getMyInfo() {
        self.getMyInfoFromServer { [weak self] response in
            guard let self = self else {
                return
            }
            self.myId = response.memberId
            self.getTeamInfo()
        }
    }
    
    func getTeamInfo() {
        self.getTeamInfoFromServer() { [weak self] response in
            guard let self = self else {
                return
            }
            self.homewView.homeGroupLabel.text = response.teamName
            self.selectedMemberId = self.myId
            self.teamId = response.teamId
            self.homewView.homeGroupCollectionView.userList = []
            if let teamMember = response.members {
                for member in teamMember {
                    if self.myId == member.memberId {
                        self.homewView.homeGroupCollectionView.userList.insert(member, at: 0)
                        self.userName = member.memberName ?? ""
                    } else {
                        self.homewView.homeGroupCollectionView.userList.append(member)
                    }
                }
            }
        }
    }
    
    func getHouseWorksByWeek(isOwn: Bool) {
        guard let firstDateInFullDateList = homewView.homeWeekCalendarCollectionView.fullDateList.first else { return }
        guard let lastDateInFullDateList = homewView.homeWeekCalendarCollectionView.fullDateList.last else { return }
        var doneWorkSum: Int = 0
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
        }
        DispatchQueue.global().async {
            if isOwn {
                self.getDateHouseWork(
                    fromDate: firstDateInFullDateList.replacingOccurrences(of: ".", with: "-"),
                    toDate: lastDateInFullDateList.replacingOccurrences(of: ".", with: "-")
                ) { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.view.isUserInteractionEnabled = true
                        self.homewView.homeWeekCalendarCollectionView.countWorkLeftWeekCalendar = [Int]()
                        self.homewView.homeWeekCalendarCollectionView.dotList = [UIImage]()
                        for date in self.homewView.homeWeekCalendarCollectionView.fullDateList {
                            if let workDate = response[date.replacingOccurrences(of: ".", with: "-")] {
                                self.homewView.homeWeekCalendarCollectionView.countWorkLeftWeekCalendar?.append(workDate.countLeft)
                                doneWorkSum = doneWorkSum + workDate.countDone
                                switch workDate.countLeft {
                                case 0:
                                    self.homewView.homeWeekCalendarCollectionView.dotList.append(UIImage())
                                case 1...3:
                                    self.homewView.homeWeekCalendarCollectionView.dotList.append(ImageLiterals.oneDot)
                                case 4...6:
                                    self.homewView.homeWeekCalendarCollectionView.dotList.append(ImageLiterals.twoDots)
                                default:
                                    self.homewView.homeWeekCalendarCollectionView.dotList.append(ImageLiterals.threeDots)
                                }
                            }
                        }
                        self.countWorkDoneInWeek = doneWorkSum
                        self.homewView.calendarDailyTableView.reloadData()
                    }
                }
            } else {
                guard let selectedMemberId = self.selectedMemberId else { return }
                self.getMemberDateHouseWork(
                    fromDate: firstDateInFullDateList.replacingOccurrences(of: ".", with: "-"),
                    toDate: lastDateInFullDateList.replacingOccurrences(of: ".", with: "-"),
                    teamMemberId: selectedMemberId
                ) { [weak self] response in
                    guard let self = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.view.isUserInteractionEnabled = true
                        self.homewView.homeWeekCalendarCollectionView.countWorkLeftWeekCalendar = [Int]()
                        self.homewView.homeWeekCalendarCollectionView.dotList = [UIImage]()
                        for date in self.homewView.homeWeekCalendarCollectionView.fullDateList {
                            if let workDate = response[date.replacingOccurrences(of: ".", with: "-")] {
                                self.homewView.homeWeekCalendarCollectionView.countWorkLeftWeekCalendar?.append(workDate.countLeft)
                                doneWorkSum = doneWorkSum + workDate.countDone
                                switch workDate.countLeft {
                                case 0:
                                    self.homewView.homeWeekCalendarCollectionView.dotList.append(UIImage())
                                case 1...3:
                                    self.homewView.homeWeekCalendarCollectionView.dotList.append(ImageLiterals.oneDot)
                                case 4...6:
                                    self.homewView.homeWeekCalendarCollectionView.dotList.append(ImageLiterals.twoDots)
                                default:
                                    self.homewView.homeWeekCalendarCollectionView.dotList.append(ImageLiterals.threeDots)
                                }
                            }
                            
                        }
                        self.countWorkDoneInWeek = doneWorkSum
                        self.homewView.calendarDailyTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func completeHouseWork(houseWorkId: Int, scheduledDate: String, completion: @escaping (HouseWorkCompleteResponse) -> Void) {
        NetworkService.shared.houseWorkCompleteRouter.completeHouseWork(houseWorkId: houseWorkId, scheduledDate: scheduledDate) { result in
            switch result {
            case .success(let response):
                guard let houseWorkCompleteId = response as? HouseWorkCompleteResponse else { return }
                self.getHouseWorksByWeek(isOwn: true)
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
                self.getHouseWorksByWeek(isOwn: true)
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
        homewView.datePickerView.setAction()
        let moveToTodayDateButtonAction = UIAction { [weak self] _ in
            self?.scrollDidEnd()
            self?.isScrolled = false
            self?.moveToTodayDate()
        }
        let moveToTodayDatePickerButtonAction = UIAction { [weak self] _ in
            self?.scrollDidEnd()
            self?.isScrolled = false
            self?.moveToDatePicker()
        }
        let moveToSettingViewAction = UIAction { [weak self] _ in
            self?.moveToSettingView()
        }
        
        homewView.homeCalenderView.todayButton.addAction(moveToTodayDateButtonAction, for: .touchUpInside)
        homewView.homeCalenderView.calendarMonthLabelButton.addAction(moveToTodayDatePickerButtonAction, for: .touchUpInside)
        homewView.homeCalenderView.calendarMonthPickButton.addAction(moveToTodayDatePickerButtonAction, for: .touchUpInside)
        homewView.profileButton.addAction(moveToSettingViewAction, for: .touchUpInside)
    }
    
    func moveToTodayDate() {
        homewView.homeCalenderView.calendarMonthLabelButton.setTitle("\(Date().yearToString)년 \(Date().monthToString)월", for: .normal)
        homewView.homeWeekCalendarCollectionView.startOfWeekDate = Date().startOfWeek
        homewView.homeWeekCalendarCollectionView.datePickedByOthers = Date().dateToString
        homewView.homeWeekCalendarCollectionView.fullDateList = homewView.homeWeekCalendarCollectionView.getThisWeekInDate()
        self.getHouseWorksByDate(
            isOwn: self.checkMemeberCellIsOwn(),
            startDate: homewView.homeWeekCalendarCollectionView.datePickedByOthers,
            endDate: homewView.homeWeekCalendarCollectionView.datePickedByOthers
        )
    }
    
    func moveToDatePicker() {
        if homewView.homeWeekCalendarCollectionView.datePickedByOthers != "" {
            homewView.datePickerView.datePicker.setDate(homewView.homeWeekCalendarCollectionView.datePickedByOthers.stringToDate ?? Date(), animated: false)
        }
        homewView.datePickerView.isHidden = false
        homewView.bringSubviewToFront(homewView.datePickerView)
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
        homewView.homeWeekCalendarCollectionView.addGestureRecognizer(leftSwipeGestureRecognizer)
        homewView.homeWeekCalendarCollectionView.addGestureRecognizer(rightSwipeGestureRecognizer)
    }
    
    func setDatePicker() {
        homewView.datePickerView.isHidden = true
        homewView.datePickerView.dismissClosure = { [weak self] pickedDate, startDateWeek, yearInString, monthInString in
            guard let self = self else {
                return
            }
            self.homewView.homeWeekCalendarCollectionView.startOfWeekDate = startDateWeek
            self.homewView.homeWeekCalendarCollectionView.datePickedByOthers = pickedDate.dateToString
            self.homewView.homeWeekCalendarCollectionView.fullDateList = self.homewView.homeWeekCalendarCollectionView.getThisWeekInDate()
            self.homewView.homeCalenderView.calendarMonthLabelButton.setTitle("\(yearInString)년 \(monthInString)월", for: .normal)
            self.homewView.datePickerView.isHidden = true
            self.getHouseWorksByDate(
                isOwn: self.checkMemeberCellIsOwn(),
                startDate: pickedDate.dateToString,
                endDate: pickedDate.dateToString
            )
            self.setupNavigationBar()
        }
        homewView.datePickerView.changeClosure = { [weak self] val in
            guard self != nil else {
                return
            }
        }
        homewView.homeWeekCalendarCollectionView.yearMonthDateByTouchedCell = { [weak self] yearDate in
            guard let self = self else {
                return
            }
            let seporateResult = yearDate.components(separatedBy: ".")
            self.homewView.homeCalenderView.calendarMonthLabelButton.setTitle("\(seporateResult[0])년 \(seporateResult[1])월", for: .normal)
        }
    }
    
    @objc func observeWeekCalendar(notification: Notification) {
        guard let object = notification.userInfo?[NotificationKey.date] as? String else { return }
        let dateArray = object.split(separator: ".")
        self.scrollDidEnd()
        self.isScrolled = false
        homewView.homeCalenderView.calendarMonthLabelButton.setTitle("\(dateArray[0])년 \(dateArray[1])월", for: .normal)
        self.getHouseWorksByDate (
            isOwn: self.checkMemeberCellIsOwn(),
            startDate: object,
            endDate: object
        )
    }
    
    @objc func observeMemberCollectionView(notification: Notification) {
        self.userName = homewView.homeGroupCollectionView.selectedMemberName
        guard let object = notification.userInfo?[NotificationKey.member] as? Int else { return }
        
        self.selectedMemberId = object
        if homewView.homeWeekCalendarCollectionView.datePickedByOthers != "" {
            self.getHouseWorksByDate (
                isOwn: self.checkMemeberCellIsOwn(),
                startDate: homewView.homeWeekCalendarCollectionView.datePickedByOthers,
                endDate: homewView.homeWeekCalendarCollectionView.datePickedByOthers
            )
        } else {
            self.getHouseWorksByDate (
                isOwn: self.checkMemeberCellIsOwn(),
                startDate: Date().dateToString,
                endDate: Date().dateToString
            )
        }
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        self.scrollDidEnd()
        isScrolled = false
        if (sender.direction == .left) {
            homewView.homeWeekCalendarCollectionView.getAfterWeekDate()
        }
        if (sender.direction == .right) {
            homewView.homeWeekCalendarCollectionView.getBeforeWeekDate()
        }
        self.getHouseWorksByDate(
            isOwn: self.checkMemeberCellIsOwn(),
            startDate: homewView.homeWeekCalendarCollectionView.fullDateList.first ?? String(),
            endDate: homewView.homeWeekCalendarCollectionView.fullDateList.first ?? String()
        )
    }
}

// MARK: - calendarDailyTableView func extension

private extension HomeViewController {
    func getDivideIndex() {
        self.divideIndex = 0
        
        for divider in self.pickDayWorkInfo?.houseWorks ?? [HouseWorkData]() {
            if divider.success == true { continue }
            self.divideIndex = self.divideIndex + 1
        }
    }
    
    func listCompleteHouseWorkLast(WorkList: [HouseWorkData]) -> [HouseWorkData] {
        var notFinishedList = [HouseWorkData]()
        var finishedList = [HouseWorkData]()
        
        for dummy in WorkList {
            if dummy.success == true { finishedList.append(dummy) }
            else { notFinishedList.append(dummy) }
        }
        return notFinishedList + finishedList
    }
    
    func countDoneHouseWork(WorkList: [HouseWorkData]) -> Int {
        var finishedHouseWorkNum = 0
        
        for dummy in WorkList {
            if dummy.success == true { finishedHouseWorkNum = finishedHouseWorkNum + 1}
        }
        return finishedHouseWorkNum
    }
    
    func scrollDidStart(){
        homewView.homeRuleView.homeRuleLabel.isHidden = true
        homewView.homeRuleView.homeRuleDescriptionLabel.isHidden = true
        homewView.homeGroupCollectionView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        homewView.homeRuleView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        homewView.homeDivider.snp.updateConstraints {
            $0.top.equalTo(homewView.homeGroupLabel.snp.bottom).offset(16)
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func scrollDidEnd() {
        homewView.homeDivider.snp.updateConstraints {
            $0.top.equalTo(homewView.homeGroupLabel.snp.bottom).offset(144)
        }
        homewView.homeGroupCollectionView.snp.updateConstraints {
            $0.height.equalTo(70)
        }
        homewView.homeRuleView.snp.updateConstraints {
            $0.height.equalTo(35)
        }
        homewView.homeRuleView.homeRuleLabel.isHidden = false
        homewView.homeRuleView.homeRuleDescriptionLabel.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func checkMemeberCellIsOwn() -> Bool {
        if myId == selectedMemberId { return true }
        else { return false }
    }
    
    func compareTime(inputTime: String) -> String {
        let currentTime = Date().dateToTimeString
        let currentTimeInInt = Int(currentTime.components(separatedBy: [":"]).joined()) ?? Int()
        let inputTimeInInt = Int(inputTime.components(separatedBy: [":"]).joined()) ?? Int()
        if Date().dateCompare(fromDate: homewView.homeWeekCalendarCollectionView.datePickedByOthers.stringToDate ?? Date()) == "Past" {
            return "over"
        } else if currentTimeInInt < inputTimeInInt {
            return "notOver"
        } else {
            return "over"
        }
    }
}
