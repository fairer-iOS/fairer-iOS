//
//  HomeWeekCalendarCollectionView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/13.
//

import UIKit

import SnapKit

final class HomeWeekCalendarCollectionView: BaseUIView {
    
    static let indentifer = "reusableView"
    private let weekDayCount: Int = 7
    
    lazy var fullDateList: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    lazy var countWorkLeft: String = String() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var countWorkLeftWeekCalendar: [Int]?
    lazy var dotList: [UIImage] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private var isSelected = false
    private var selectedCell = Int()
    private let dayList = TextLiteral.homeCalendarViewDaysTitle
    lazy var startOfWeekDate = Date().startOfWeek
    private var todayDate = Date()
    lazy var todayDateInString = Date().dateToString
    lazy var datePickedByOthers = todayDateInString
    var yearMonthDateByTouchedCell: ((String)->())?
    private enum Size {
        static let collectionSpacing: CGFloat = 0
        static let cellWidth: CGFloat = UIScreen.main.bounds.width * 0.10
        static let cellHeight: CGFloat = 68
        static let collectionInsets = UIEdgeInsets(
            top: collectionSpacing,
            left: collectionSpacing,
            bottom: collectionSpacing,
            right: collectionSpacing)
    }
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        return flowLayout
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: HomeWeekCalendarCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeWeekCalendarCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.fullDateList = getThisWeekInDate()
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    func getTodayDateInInt() -> Int {
        let ampmIndex = todayDate.dateToString.index(todayDate.dateToString.endIndex, offsetBy: -2)
        let ampmStr = String(todayDate.dateToString[ampmIndex...])
        let result = Int(ampmStr) ?? 0
        return result
    }
    
    func getThisWeekInInt() -> [String] {
        var resultArr = [String]()
        let ampmIndex = startOfWeekDate.dateToString.index(startOfWeekDate.dateToString.endIndex, offsetBy: -2)
        let ampmStr = String(startOfWeekDate.dateToString[ampmIndex...])
        resultArr.append(ampmStr)
        var currentDate = startOfWeekDate
        for _ in 0...5 {
            let date: Date = currentDate.addingTimeInterval(+86400)
            let ampmIndex = date.dateToString.index(date.dateToString.endIndex, offsetBy: -2)
            let ampmStr = String(date.dateToString[ampmIndex...])
            resultArr.append(ampmStr)
            currentDate = date
        }
        return resultArr
    }
    
    func getThisWeekInDate() -> [String] {
        var resultArr = [String]()
        resultArr.append(startOfWeekDate.dateToString)
        var currentDate = startOfWeekDate
        for _ in 0...5 {
            let date: Date = currentDate.addingTimeInterval(+86400)
            resultArr.append(date.dateToString)
            currentDate = date
        }
        return resultArr
    }
    
    func getAfterWeekDate() {
        let currentDateListForFullDate = fullDateList
        var resultFullWeekData = [String]()
        for date in currentDateListForFullDate {
            var afterFullWeekDate = date.stringToDate
            for _ in 0...6 {
                afterFullWeekDate = afterFullWeekDate?.addingTimeInterval(+86400)
            }
            resultFullWeekData.append(afterFullWeekDate?.dateToString ?? String())
        }
        self.fullDateList = resultFullWeekData
        self.datePickedByOthers = self.fullDateList.first ?? String()
        yearMonthDateByTouchedCell?(self.fullDateList.first ?? String())
    }
    
    func getBeforeWeekDate() {
        let currentDateListForFullDate = fullDateList
        var resultFullWeekData = [String]()
        for date in currentDateListForFullDate {
            var afterFullWeekDate = date.stringToDate
            for _ in 0...6 {
                afterFullWeekDate = afterFullWeekDate?.addingTimeInterval(-86400)
            }
            resultFullWeekData.append(afterFullWeekDate?.dateToString ?? String())
        }
        self.fullDateList = resultFullWeekData
        self.datePickedByOthers = self.fullDateList.first ?? String()
        yearMonthDateByTouchedCell?(self.fullDateList.first ?? String())
    }
}

// MARK: - extension

extension HomeWeekCalendarCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        datePickedByOthers = self.fullDateList[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name.date, object: nil, userInfo: [NotificationKey.date: datePickedByOthers])
    }
}

extension HomeWeekCalendarCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDayCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeWeekCalendarCollectionViewCell.className, for: indexPath) as? HomeWeekCalendarCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        let seporateDate = fullDateList[indexPath.row].components(separatedBy: ".")
        cell.dayLabel.text = dayList[indexPath.item]
        cell.dateLabel.text = seporateDate[2]
        if dotList.isEmpty {
            cell.workDot.isHidden = true
        } else {
            cell.workDot.image = dotList[indexPath.row]
        }
        cell.workLeftLabel.text = self.countWorkLeft
        guard self.datePickedByOthers != "" else {
            if fullDateList[indexPath.item] == self.todayDateInString {
                self.isSelected = true
                self.selectedCell = indexPath.row
                cell.globalView.backgroundColor = UIColor.gray100
                cell.dateLabel.textColor = UIColor.blue
                cell.dayLabel.textColor = UIColor.blue
                cell.dayLabel.font = .title2
                cell.dateLabel.font = .title2
                if let countWorkLeftWeekCalendar = countWorkLeftWeekCalendar {
                    if countWorkLeftWeekCalendar[indexPath.row] == 0 {
                        cell.workDot.image = dotList[indexPath.row]
                        cell.workBlueBadge.isHidden = true
                        cell.workLeftLabel.isHidden = true
                    } else {
                        cell.workDot.isHidden = true
                        if self.countWorkLeft == "0" {
                            cell.workLeftLabel.isHidden = true
                            cell.workBlueBadge.isHidden = true
                        } else {
                            cell.workBlueBadge.isHidden = false
                            cell.workLeftLabel.isHidden = false
                            cell.workLeftLabel.text = self.countWorkLeft
                        }
                    }
                }
            }
            return cell
        }
        if fullDateList[indexPath.item] == self.datePickedByOthers {
            self.isSelected = true
            self.selectedCell = indexPath.row
            cell.globalView.backgroundColor = UIColor.gray100
            cell.dateLabel.textColor = UIColor.blue
            cell.dayLabel.textColor = UIColor.blue
            cell.dayLabel.font = .title2
            cell.dateLabel.font = .title2
            if let countWorkLeftWeekCalendar = countWorkLeftWeekCalendar {
                if countWorkLeftWeekCalendar[indexPath.row] == 0 {
                    cell.workDot.image = dotList[indexPath.row]
                    cell.workBlueBadge.isHidden = true
                    cell.workLeftLabel.isHidden = true
                } else {
                    cell.workDot.isHidden = true
                    if self.countWorkLeft == "0" {
                        cell.workLeftLabel.isHidden = true
                        cell.workBlueBadge.isHidden = true
                    } else {
                        cell.workBlueBadge.isHidden = false
                        cell.workLeftLabel.isHidden = false
                        cell.workLeftLabel.text = self.countWorkLeft
                    }
                }
            }
        }
        return cell
    }
}
