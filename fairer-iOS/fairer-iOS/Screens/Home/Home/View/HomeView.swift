//
//  HomeView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/04/30.
//

import UIKit

import SnapKit

final class HomeView: BaseUIView {
    let logoImage = UIImageView(image: ImageLiterals.imgHomeLogo)
    let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(ImageLiterals.settingMenu, for: .normal)
        button.tintColor = .black
        return button
    }()
    let toolBarView = HomeViewControllerToolBar()
    let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .title1
        label.numberOfLines = 2
        return label
    }()
    let countDoneTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .title1
        label.text = TextLiteral.homeViewDefaultCountDoneTitleLabel
        label.numberOfLines = 2
        return label
    }()
    let titleLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    let houseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.homeIcon
        imageView.tintColor = .gray400
        return imageView
    }()
    let homeGroupLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .gray400
        return label
    }()
    let homeGroupCollectionView = HomeGroupCollectionView()
    let homeRuleView = HomeRuleView()
    let homeDivider: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray100.cgColor
        return view
    }()
    let homeCalenderView = HomeCalendarView()
    let homeWeekCalendarCollectionView = HomeWeekCalendarCollectionView()
    let calendarDailyTableView: UITableView = {
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
    let emptyHouseWorkImage = UIImageView(image: ImageLiterals.emptyHouseWork)
    let emojiView = EmojiCollectionView()
    
    override func render() {
        self.addSubviews(toolBarView,
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
                         emptyHouseWorkImage,
                         emojiView)
        
        toolBarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(76)
        }
        
        titleLabelStackView.addArrangedSubview(nameTitleLabel)
        titleLabelStackView.addArrangedSubview(countDoneTitleLabel)
        
        titleLabelStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.height.equalTo(45)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        houseImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabelStackView.snp.bottom).offset(16)
            $0.size.equalTo(16)
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
            $0.height.equalTo(68)
        }
        
        calendarDailyTableView.snp.makeConstraints {
            $0.top.equalTo(homeWeekCalendarCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(toolBarView.snp.top)
        }
        
        datePickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyHouseWorkImage.snp.makeConstraints {
            $0.top.equalTo(homeWeekCalendarCollectionView.snp.bottom).offset(10)
            $0.bottom.equalTo(toolBarView.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(emptyHouseWorkImage.snp.height).multipliedBy(0.65)
        }
        
        emojiView.snp.makeConstraints {
            $0.top.equalTo(calendarDailyTableView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.equalTo(UIScreen.main.bounds.width * 0.9)
            $0.height.equalTo(52)
        }
    }
}
