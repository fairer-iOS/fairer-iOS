//
//  HomeViewController.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class HomeViewController: BaseViewController {
    
    // TODO: - 추후 api연결 + UserDefault
    
    let userName: String = "고가혜"
    let ruleArray: [String] = ["설거지는 바로바로", "신발 정리하기", "화분 물주기", "밥 다먹은 사람이 치우기"]
    private var isScrolled = false
    private lazy var leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    private lazy var rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    
    // MARK: - property
    
    private var cellHeight = CGFloat()
    private let logoImage = UIImageView(image: ImageLiterals.imgHomeLogo)
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(ImageLiterals.settingMenu, for: .normal)
        button.tintColor = .black
        return button
    }()
    private let toolBarView = HomeViewControllerToolBar()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "\(userName)님\n아직 집안일을 하지 않으셨네요."
        label.font = .title1
        label.applyColor(to: userName, with: .blue)
        label.numberOfLines = 2
        return label
    }()
    private let houseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.houseFill
        imageView.tintColor = .gray400
        return imageView
    }()
    private let homeGroupLabel: UILabel = {
        let label = UILabel()
        label.text = "즐거운 우리집"
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
    private let calendarDailyCollecionView = CalendarDailyCollectionView()
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    let datePickerView: PickDateView = {
        let v = PickDateView()
        return v
    }()
    
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
    }

    override func configUI() {
        super.configUI()
        setCalendarHight()
        setupToolBarGesture()
        setHomeRuleLabel()
    }
    
    override func render() {
        view.addSubviews(toolBarView,
                         titleLabel,
                         houseImageView,
                         homeGroupLabel,
                         contentScrollView,
                         homeGroupCollectionView,
                         homeRuleView,
                         homeDivider,
                         datePickerView)
        
        contentScrollView.addSubviews(
            homeCalenderView,
            homeWeekCalendarCollectionView,
            calendarDailyCollecionView
        )
        
        toolBarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(76)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        houseImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }

        homeGroupLabel.snp.makeConstraints {
            $0.leading.equalTo(houseImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(houseImageView.snp.centerY)
        }

        homeGroupCollectionView.snp.makeConstraints {
            $0.top.equalTo(houseImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(86)
        }

        homeRuleView.snp.makeConstraints {
            $0.top.equalTo(homeGroupCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(40)
        }
        
        homeDivider.snp.makeConstraints {
            $0.top.equalTo(homeGroupLabel.snp.bottom).offset(150)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(2)
        }
        
        contentScrollView.snp.makeConstraints {
            $0.top.equalTo(homeDivider.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(toolBarView.snp.top)
        }
        
        homeCalenderView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(40)
        }
        
        homeWeekCalendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(homeCalenderView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(95)
        }

        calendarDailyCollecionView.snp.makeConstraints {
            $0.top.equalTo(homeWeekCalendarCollectionView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(310)
            $0.bottom.equalToSuperview()
        }
        
        datePickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
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
    
    // MARK: - func
    
    private func setButtonEvent() {
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
    
    private func setupDelegate() {
        self.contentScrollView.delegate = self
    }
    
    private func setupToolBarGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addTapGesture))
        toolBarView.addGestureRecognizer(tapGesture)
    }
    
    private func setHomeRuleLabel() {
        var index = 0
        if ruleArray.isEmpty {
            homeRuleView.homeRuleDescriptionLabel.text = TextLiteral.homeRuleViewRuleDescriptionLabel
        } else {
            homeRuleView.homeRuleDescriptionLabel.text = ruleArray[index]
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
                guard let count = self?.ruleArray.count else { return }
                self?.homeRuleView.homeRuleDescriptionLabel.text = self?.ruleArray[index]
                index += 1
                if index > count - 1 {
                    index = 0
                }
            }
        }
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
            $0.top.equalTo(self.homeGroupLabel.snp.bottom).offset(150)
        }
        self.homeGroupCollectionView.snp.updateConstraints {
            $0.height.equalTo(86)
        }
        self.homeRuleView.snp.updateConstraints {
            $0.height.equalTo(40)
        }
        self.homeRuleView.homeRuleLabel.isHidden = false
        self.homeRuleView.homeRuleDescriptionLabel.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        })
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
            self.homeWeekCalendarCollectionView.dateList = self.homeWeekCalendarCollectionView.getThisWeekInInt()
            self.homeWeekCalendarCollectionView.fullDateList = self.homeWeekCalendarCollectionView.getThisWeekInDate()
            self.homeWeekCalendarCollectionView.collectionView.reloadData()
            self.homeCalenderView.calendarMonthLabelButton.setTitle("\(yearInString)년 \(monthInString)월", for: .normal)
            self.homeWeekCalendarCollectionView.datePickedByOthers = pickedDate.dateToString
            self.datePickerView.isHidden = true
            self.setupNavigationBar()
        }
        datePickerView.changeClosure = { [weak self] val in
            guard self != nil else {
                return
            }
        }
    }

    // MARK: - selector
    
    @objc
    private func addTapGesture() {
        // FIXME: - 집안일 추가 뷰로 연결
        print("tap")
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            self.homeWeekCalendarCollectionView.getAfterWeekDate()
        }
            
        if (sender.direction == .right) {
            self.homeWeekCalendarCollectionView.getBeforeWeekDate()
        }
    }
    
    private func moveToTodayDate() {
        self.homeWeekCalendarCollectionView.datePickedByOthers = ""
        self.homeCalenderView.calendarMonthLabelButton.setTitle("\(Date().yearToString)년 \(Date().monthToString)월", for: .normal)
        self.homeWeekCalendarCollectionView.startOfWeekDate = Date().startOfWeek
        self.homeWeekCalendarCollectionView.dateList = self.homeWeekCalendarCollectionView.getThisWeekInInt()
        self.homeWeekCalendarCollectionView.fullDateList = self.homeWeekCalendarCollectionView.getThisWeekInDate()
        self.homeWeekCalendarCollectionView.collectionView.reloadData()
    }
    
    private func moveToDatePicker() {
        self.homeWeekCalendarCollectionView.datePickedByOthers = ""
        self.datePickerView.isHidden = false
        self.setupAlphaNavigationBar()
    }
    
    private func setCalendarHight() {
        self.calendarDailyCollecionView.changeHeightClosure = { [weak self]
            cellNum in
            guard let self = self else {
                return
            }
            self.cellHeight = CGFloat(cellNum) * SizeLiteral.homeViewWorkCellHeight
            self.calendarDailyCollecionView.snp.updateConstraints {
                $0.height.equalTo(self.cellHeight)
            }
        }
    }
}

    // MARK: - extension

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        if (scrollOffset <= 5) {
            scrollDidEnd()
            isScrolled = false
        } else {
            if !isScrolled {
                scrollDidStart()
                isScrolled = true
            }
        }
    }
}
