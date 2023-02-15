//
//  HomeWeekCalendarCollectionView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/13.
//

import UIKit

import SnapKit

final class HomeWeekCalendarCollectionView: BaseUIView {
    
    static var indentifer = "reusableView"
    
    private var isSelected = false
    private var selectedCell = Int()
    private var cellIndexPath = IndexPath()
    private let dotList = [ImageLiterals.oneDot,ImageLiterals.oneDot,ImageLiterals.twoDots,ImageLiterals.oneDot,ImageLiterals.twoDots,ImageLiterals.threeDots,ImageLiterals.twoDots]
    private let dayList = ["일","월","화","수","목","금","토"]
    lazy var dateList = [String]()
    lazy var fullDateList = [String]()
    lazy var startOfWeekDate = Date().startOfWeek
    private var todayDate = Date()
    private var todayDateInString = Date().dateToString
    lazy var datePickedByOthers = ""
    var yearMonthDateByTouchedCell: ((String)->())?
    private enum Size {
        static let collectionSpacing: CGFloat = 0
        static let cellWidth: CGFloat = 40
        static let cellHeight: CGFloat = 56
        static let collectionInsets = UIEdgeInsets(
            top: collectionSpacing,
            left: collectionSpacing,
            bottom: collectionSpacing,
            right: collectionSpacing)
    }
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 8
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
        self.dateList = getThisWeekInInt()
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
        let currentDateList = dateList
        let currentDateListForFullDate = fullDateList
        var resultWeekData = [String]()
        var resultFullWeekData = [String]()
        for date in currentDateList {
            var afterWeekDate = date.stringToDay
            for _ in 0...6 {
                afterWeekDate = afterWeekDate?.addingTimeInterval(+86400)
            }
            resultWeekData.append(afterWeekDate?.dayToString ?? String())
        }
        for date in currentDateListForFullDate {
            var afterFullWeekDate = date.stringToDate
            for _ in 0...6 {
                afterFullWeekDate = afterFullWeekDate?.addingTimeInterval(+86400)
            }
            resultFullWeekData.append(afterFullWeekDate?.dateToString ?? String())
        }
        self.dateList = resultWeekData
        self.fullDateList = resultFullWeekData
        self.datePickedByOthers = self.fullDateList.first ?? String()
        print(dateList)
        print(fullDateList)
        collectionView.reloadData()
    }
    
    func getBeforeWeekDate() {
        let currentDateList = dateList
        let currentDateListForFullDate = fullDateList
        var resultWeekData = [String]()
        var resultFullWeekData = [String]()
        for date in currentDateList {
            var afterWeekDate = date.stringToDay
            for _ in 0...6 {
                afterWeekDate = afterWeekDate?.addingTimeInterval(-86400)
            }
            resultWeekData.append(afterWeekDate?.dayToString ?? String())
        }
        for date in currentDateListForFullDate {
            var afterFullWeekDate = date.stringToDate
            for _ in 0...6 {
                afterFullWeekDate = afterFullWeekDate?.addingTimeInterval(-86400)
            }
            resultFullWeekData.append(afterFullWeekDate?.dateToString ?? String())
        }
        self.dateList = resultWeekData
        self.fullDateList = resultFullWeekData
        self.datePickedByOthers = self.fullDateList.first ?? String()
        print(dateList)
        print(fullDateList)
        collectionView.reloadData()
    }
}

// MARK: - Extension

extension HomeWeekCalendarCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.datePickedByOthers = ""
        if self.isSelected == false {
            self.isSelected = true
            self.selectedCell = indexPath.row
            self.cellIndexPath = indexPath
            let firstCell  = collectionView.cellForItem(at: indexPath) as! HomeWeekCalendarCollectionViewCell
            firstCell.globalView.backgroundColor = UIColor.gray100
            firstCell.dateLabel.textColor = UIColor.blue
            firstCell.dayLabel.textColor = UIColor.blue
            firstCell.workDot.image = ImageLiterals.selectedCalendarCell
            yearMonthDateByTouchedCell?(self.fullDateList[indexPath.row])
        }else if indexPath.row != self.selectedCell {
            let resetCell  = collectionView.cellForItem(at: self.cellIndexPath) as! HomeWeekCalendarCollectionViewCell
            resetCell.globalView.backgroundColor = UIColor.systemBackground
            resetCell.dateLabel.textColor = UIColor.gray400
            resetCell.dayLabel.textColor = UIColor.gray400
            resetCell.workDot.image = dotList[self.cellIndexPath.row]
            let secondCell = collectionView.cellForItem(at: indexPath) as! HomeWeekCalendarCollectionViewCell
            secondCell.globalView.backgroundColor = UIColor.gray100
            secondCell.dateLabel.textColor = UIColor.blue
            secondCell.dayLabel.textColor = UIColor.blue
            secondCell.workDot.image = ImageLiterals.selectedCalendarCell
            self.isSelected = true
            self.selectedCell = indexPath.row
            self.cellIndexPath = indexPath
            yearMonthDateByTouchedCell?(self.fullDateList[indexPath.row])
        }
    }
}

extension HomeWeekCalendarCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeWeekCalendarCollectionViewCell.className, for: indexPath) as? HomeWeekCalendarCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        cell.dayLabel.text = dayList[indexPath.item]
        cell.dateLabel.text = dateList[indexPath.item]
        cell.workDot.image = dotList[indexPath.item]
        guard self.datePickedByOthers != "" else {
            if fullDateList[indexPath.item] == self.todayDateInString {
                self.isSelected = true
                self.selectedCell = indexPath.row
                self.cellIndexPath = indexPath
                cell.globalView.backgroundColor = UIColor.gray100
                cell.dateLabel.textColor = UIColor.blue
                cell.dayLabel.textColor = UIColor.blue
                cell.workDot.image = ImageLiterals.selectedCalendarCell
            }
            return cell
        }
        if fullDateList[indexPath.item] == self.datePickedByOthers {
            self.isSelected = true
            self.selectedCell = indexPath.row
            self.cellIndexPath = indexPath
            cell.globalView.backgroundColor = UIColor.gray100
            cell.dateLabel.textColor = UIColor.blue
            cell.dayLabel.textColor = UIColor.blue
            cell.workDot.image = ImageLiterals.selectedCalendarCell
        }
        return cell
    }
}
