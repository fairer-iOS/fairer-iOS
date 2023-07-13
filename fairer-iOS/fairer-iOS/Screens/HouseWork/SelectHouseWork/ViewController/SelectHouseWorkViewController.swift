//
//  SelectHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/20.
//

import UIKit

import SnapKit

final class SelectHouseWorkViewController: BaseViewController {
    
    var selectedSpace: Space?
    var houseWorks: [String] = []
    var houseWorksRequest: [HouseWorksRequest] = []
    var scheduledDate = Date().dateToAPIString
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let selectHouseWorkCalendar = PickDateButton()
    private let spaceCollectionView = SelectHouseWorkSpaceCollectionView()
    private let spaceInfoLabel: InfoLabelView = {
        let label = InfoLabelView()
        label.text = TextLiteral.selectHouseWorkViewControllerInfoLabel
        label.textColor = .gray600
        label.imageColor = .gray200
        return label
    }()
    private let detailHouseWorkLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.selectHouseWorkViewControllerDetailHouseWorkLabel, lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        label.isHidden = true
        return label
    }()
    private let detailCollectionView = SelectHouseWorkDetailCollectionView()
    private let writeHouseWorkLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.selectHouseWorkViewControllerWriteHouseWorkLabel, lineHeight: 22)
        label.textColor = .gray300
        label.font = .body2
        label.isHidden = true
        return label
    }()
    private lazy var writeHouseWorkButton: WriteHouseWorkButton = {
        let button = WriteHouseWorkButton()
        let action = UIAction { [weak self] _ in
            self?.didTappedWriteHouseWorkButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let nextButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private lazy var nextButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.selectHouseWorkViewControllerNextButtonText
        button.isDisabled = true
        let action = UIAction { [weak self] _ in
            self?.didTappedNextButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let datePickerView = PickDateView()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        didTappedSpace()
        didTappedHouseWork()
        showDisableAlert()
    }
    
    override func render() {
        view.addSubview(nextButtonBackgroundView)
        nextButtonBackgroundView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(122)
        }
        
        nextButtonBackgroundView.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextButtonBackgroundView.snp.top)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.edges.equalToSuperview()
        }
        
        contentView.addSubview(selectHouseWorkCalendar)
        selectHouseWorkCalendar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(22)
        }
        
        contentView.addSubview(spaceCollectionView)
        spaceCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectHouseWorkCalendar.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(248)
        }
        
        contentView.addSubview(spaceInfoLabel)
        spaceInfoLabel.snp.makeConstraints {
            $0.top.equalTo(spaceCollectionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(22)
        }
        
        contentView.addSubview(detailHouseWorkLabel)
        detailHouseWorkLabel.snp.makeConstraints {
            $0.top.equalTo(spaceCollectionView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(0)
        }
        
        contentView.addSubview(detailCollectionView)
        detailCollectionView.snp.makeConstraints {
            $0.top.equalTo(detailHouseWorkLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        contentView.addSubview(writeHouseWorkLabel)
        writeHouseWorkLabel.snp.makeConstraints {
            $0.top.equalTo(detailCollectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        contentView.addSubview(writeHouseWorkButton)
        writeHouseWorkButton.snp.makeConstraints {
            $0.top.equalTo(writeHouseWorkLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(42)
            $0.bottom.equalTo(0)
        }
        
        view.addSubview(datePickerView)
        datePickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setDatePicker() {
        datePickerView.isHidden = true
        datePickerView.setAction()
        
        let action = UIAction { [weak self] _ in
            self?.presentPickDateView()
        }
        selectHouseWorkCalendar.addAction(action, for: .touchUpInside)
    }
    
    private func didTappedWriteHouseWorkButton() {
        let writeHouseWorkView = WriteHouseWorkViewController()
        self.navigationController?.pushViewController(writeHouseWorkView, animated: true)
    }
    
    private func didTappedNextButton() {
        self.houseWorksRequest = houseWorks.map { houseWorkName in
            HouseWorksRequest(assignees: [], houseWorkName: houseWorkName, repeatPattern: self.scheduledDate, scheduledDate: self.scheduledDate, space: selectedSpace?.spaceUpper ?? "")
        }
        let setHouseWorkView = SetHouseWorkViewController(houseWorks: houseWorksRequest)
        self.navigationController?.pushViewController(setHouseWorkView, animated: true)
    }
    
    private func didTappedSpace() {
        spaceCollectionView.didTappedSpace = {[weak self] space in
            self?.setDetailHouseWork(space)
            self?.setLabels()
            self?.selectedSpace = space
        }
    }
    
    private func didTappedHouseWork() {
        detailCollectionView.didTappedHouseWork = {[weak self] houseWork in
            if houseWork.count > 0 {
                self?.nextButton.isDisabled = false
                self?.spaceCollectionView.didChangeSpaceWithHouseWork = true
            } else {
                self?.nextButton.isDisabled = true
            }
            self?.houseWorks = houseWork
        }
    }
    
    private func showDisableAlert() {
        spaceCollectionView.showDisableAlert = {[weak self] showDisableAlert in
            if showDisableAlert {
                self?.makeAlert(title: TextLiteral.selectHouseWorkViewControllerAlertTitle, message: TextLiteral.selectHouseWorkViewControllerAlertMessage, okAction: { [weak self] _ in self?.resetSpace() })
            }
        }
    }
    
    private func resetSpace() {
        detailCollectionView.selectedHouseWorkList = []
        detailCollectionView.collectionView.reloadData()
        spaceCollectionView.collectionView.reloadData()
        nextButton.isDisabled = true
        spaceCollectionView.didChangeSpaceWithHouseWork = false
    }
    
    private func setDetailHouseWork(_ space: Space) {
        let height = space.houseWorkDetailSize
        detailCollectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
        detailCollectionView.space = space
    }
    
    private func setLabels() {
        writeHouseWorkLabel.isHidden = false
        
        spaceInfoLabel.isHidden = true
        spaceInfoLabel.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        
        detailHouseWorkLabel.isHidden = false
        detailHouseWorkLabel.snp.updateConstraints {
            $0.height.equalTo(26)
        }
    }
    
    private func presentPickDateView() {
        datePickerView.isHidden = false
        datePickerView.dismissClosure = { [weak self] pickedDate, startDateWeek, yearInString, monthInString in
            self?.datePickerView.isHidden = true
            self?.selectHouseWorkCalendar.dateLabel.text = pickedDate.dayToKoreanString
            self?.scheduledDate = pickedDate.dateToAPIString
        }
    }
}
