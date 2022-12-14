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
    
    override func render() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        
        contentView.addSubview(writeHouseWorkButton)
        writeHouseWorkButton.snp.makeConstraints {
            $0.top.equalTo(spaceInfoLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(42)
            $0.bottom.equalTo(0)
        }
        
        view.addSubview(nextButtonBackgroundView)
        nextButtonBackgroundView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(122)
        }
        
        nextButtonBackgroundView.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
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
        // FIXME: - ????????? ?????? ???????????? ???????????? ??????
        print("????????? ?????? ????????????")
    }
    
    private func didTappedNextButton() {
        // FIXME: - ????????? ???????????? ???????????? ??????
        print("??????")
    }
}
