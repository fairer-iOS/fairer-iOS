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
    
    // MARK: - property
    
    private var cellHeight = CGFloat()
    private let logoImage : UIImageView = {
        let imgView = UIImageView()
        imgView.image = ImageLiterals.imgHomeLogo
        return imgView
    }()
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
    
    // MARK: - life cycle
    
    deinit {
        print("HomeViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegate()
    }
    
    override func configUI() {
        super.configUI()
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
                         homeDivider)
        
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
            $0.top.equalTo(homeGroupLabel.snp.bottom).offset(144)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(2)
        }
        
        contentScrollView.snp.makeConstraints{
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

        calendarDailyCollecionView.snp.makeConstraints{
            $0.top.equalTo(homeWeekCalendarCollectionView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(310)
            $0.bottom.equalToSuperview()
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
    
    // MARK: - func
    
    private func setupDelegate(){
        self.calendarDailyCollecionView.delegate = self
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
        UIView.animate(withDuration: 0.2 ,delay: 0 ,options: .transitionCurlUp ,animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func scrollDidEnd(){
        self.homeDivider.snp.updateConstraints {
            $0.top.equalTo(self.homeGroupLabel.snp.bottom).offset(144)
        }
        self.homeGroupCollectionView.snp.updateConstraints {
            $0.height.equalTo(86)
        }
        self.homeRuleView.snp.updateConstraints {
            $0.height.equalTo(40)
        }
        self.homeRuleView.homeRuleLabel.isHidden = false
        self.homeRuleView.homeRuleDescriptionLabel.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0 ,options: .transitionCurlUp ,animations: {
            self.view.layoutIfNeeded()
        })
    }

    // MARK: - selector
    
    @objc
    private func addTapGesture() {
        // FIXME: - 집안일 추가 뷰로 연결
        print("tap")
    }
}

    // MARK: - Protocol
protocol CollectionViewHeightProtocol: AnyObject {
    func getCollectionViewHeight(cellNum: Int)
}

    // MARK: - Extension
extension HomeViewController: CollectionViewHeightProtocol {
    func getCollectionViewHeight(cellNum: Int) {
        cellHeight = CGFloat(cellNum) * SizeLiteral.homeViewWorkCellHeight
        calendarDailyCollecionView.snp.updateConstraints {
            $0.height.equalTo(cellHeight)
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        if (scrollOffset <= 5) {
            print("its top")
            scrollDidEnd()
            isScrolled = false
        }else{
            if isScrolled == false {
                print("scrolling start")
                scrollDidStart()
                isScrolled = true
            }else {
                print("still scrolling")
            }
        }
    }
}
