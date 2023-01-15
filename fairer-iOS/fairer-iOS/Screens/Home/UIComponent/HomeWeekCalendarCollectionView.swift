//
//  HomeWeekCalendarCollectionView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/13.
//

import UIKit

import SnapKit

final class HomeWeekCalendarCollectionView: BaseUIView {
    
    // 캘린더 터치 이벤트 로직 관련 변수
    var isSelected = false
    var selectedCell = Int()
    var cellIndexPath = IndexPath()
    
    let dotList = [UIImage(named: "dot.svg"),UIImage(named: ""),UIImage(named: "2dot.svg"),UIImage(named: "dot.svg"),UIImage(named: ""),UIImage(named: "3dot.svg"),UIImage(named: "2dot.svg")]
    let dayList = ["일","월","화","수","목","금","토"]
    let dateList = ["10","11","12","13","14","15","16"]
    var startOfWeekDate = Date().startOfWeek
    var endOfWeekDate = Date().endOfWeek
    var todayDate = Date()
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 8
        static let collectionVerticalSpacing: CGFloat = 0
        static let cellWidth: CGFloat = 40
        static let cellHeight: CGFloat = 56
        static let collectionInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: collectionHorizontalSpacing,
            bottom: collectionVerticalSpacing,
            right: collectionHorizontalSpacing)
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
    private lazy var collectionView: UICollectionView = {
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
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension HomeWeekCalendarCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 주간 캘린더 선택 이벤트 로직
        // 여기 로직 첫 if문 지워도 될듯 (일단 유지)
        if self.isSelected == false {
            print("first")
            self.isSelected = true
            self.selectedCell = indexPath.row
            self.cellIndexPath = indexPath
            let firstCell  = collectionView.cellForItem(at: indexPath) as! HomeWeekCalendarCollectionViewCell
            firstCell.globalView.backgroundColor = UIColor.gray100
            firstCell.dateLabel.textColor = UIColor.blue
            firstCell.dayLabel.textColor = UIColor.blue
            firstCell.workDot.image = UIImage(named: "selectedCell.svg")
            
        }else if indexPath.row != self.selectedCell {
            print("second")
            // 이전에 선택된 셀 초기화
            let resetCell  = collectionView.cellForItem(at: self.cellIndexPath) as! HomeWeekCalendarCollectionViewCell
            resetCell.globalView.backgroundColor = UIColor.systemBackground
            resetCell.dateLabel.textColor = UIColor.gray400
            resetCell.dayLabel.textColor = UIColor.gray400
            resetCell.workDot.image = dotList[self.cellIndexPath.row]
            
            // 선택된 셀 커스텀
            let secondCell = collectionView.cellForItem(at: indexPath) as! HomeWeekCalendarCollectionViewCell
            secondCell.globalView.backgroundColor = UIColor.gray100
            secondCell.dateLabel.textColor = UIColor.blue
            secondCell.dayLabel.textColor = UIColor.blue
            secondCell.workDot.image = UIImage(named: "selectedCell.svg")
            
            self.isSelected = true
            self.selectedCell = indexPath.row
            self.cellIndexPath = indexPath
        }
        // 최종 indexPath.row는 선택된 cell의 인덱스 값
        print("click index=\(indexPath.row)")
    }
    
    // 오늘 날짜의 '일'을 정수로 리턴하는 함수
    func getTodayDateInInt()->Int{
        let ampmIndex = todayDate.dateToString.index(startOfWeekDate.dateToString.endIndex, offsetBy: -2)
        let ampmStr = String(startOfWeekDate.dateToString[ampmIndex...])
        let result = Int(ampmStr) ?? 0
        print(result)
        return result
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
        
        // 오늘날짜 확인하여 셀 스타일 변경하는 부분
        if Int(dateList[indexPath.item]) ?? 0 == self.getTodayDateInInt() {
            self.isSelected = true
            self.selectedCell = indexPath.row
            self.cellIndexPath = indexPath
            cell.globalView.backgroundColor = UIColor.gray100
            cell.dateLabel.textColor = UIColor.blue
            cell.dayLabel.textColor = UIColor.blue
            cell.workDot.image = UIImage(named: "selectedCell.svg")
        }
    
        return cell
    }
}
