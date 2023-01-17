//
//  SelectHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/20.
//

import UIKit

import SnapKit

final class SelectHouseWorkViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let selectHouseWorkCalendar = SelectHouseWorkCalendarView()
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
        label.setTextWithLineHeight(text: "세부 집안일", lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        label.isHidden = true
        return label
    }()
    private let detailCollectionView = SelectHouseWorkDetailCollectionView()
    private let writeHouseWorkLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "원하는 집안일이 없나요?", lineHeight: 22)
        label.textColor = .gray300
        label.font = .body2
        label.isHidden = true
        return label
    }()
    private lazy var writeHouseWorkButton: WriteHouseWorkButton = {
        let button = WriteHouseWorkButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.positive20.cgColor
        button.layer.cornerRadius = 6
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
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTappedSpace()
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
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalToSuperview().inset(15)
        }
        
        contentView.addSubview(spaceCollectionView)
        spaceCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectHouseWorkCalendar.snp.bottom).offset(4)
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
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func didTappedWriteHouseWorkButton() {
        // FIXME: - 집안일 직접 입력하기 페이지로 이동
        print("집안일 직접 입력하기")
    }
    
    private func didTappedNextButton() {
        // FIXME: - 집안일 설정하기 페이지로 이동
        print("다음")
    }
    
    private func didTappedSpace() {
        spaceCollectionView.didTappedSpace = {[weak self] space in
            let numOfHouseWork = space.houseWorkDetailList.count
            let height: Int
            if numOfHouseWork <= 3 {
                height = 80
            } else if numOfHouseWork > 6 {
                height = 228
            } else {
                height = 154
            }
            
            self?.spaceInfoLabel.isHidden = true
            self?.detailCollectionView.space = space
            self?.detailHouseWorkLabel.isHidden = false
            self?.writeHouseWorkLabel.isHidden = false
            self?.detailCollectionView.snp.updateConstraints {
                $0.height.equalTo(height)
            }
            self?.spaceInfoLabel.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            self?.detailHouseWorkLabel.snp.updateConstraints {
                $0.height.equalTo(26)
            }
        }
    }
}
