//
//  CalendarDailyTableViewCell.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/13.
//

import UIKit

import SnapKit

final class CalendarDailyTableViewCell: BaseTableViewCell {
    
    static let identifier = "CellId"
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 0
        static let collectionVerticalSpacing: CGFloat = 0
        static let cellWidth: CGFloat = 24
        static let cellHeight: CGFloat = 24
        static let collectionInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: collectionHorizontalSpacing,
            bottom: collectionVerticalSpacing,
            right: collectionHorizontalSpacing)
    }
    
    // MARK: - property
    
    let workLabel: UILabel = {
        let label = UILabel()
        label.font = .title1
        label.textColor = .gray800
        return label
    }()
    let time: UILabel = {
        let label = UILabel()
        label.font = UIFont.caption1
        label.textColor = UIColor.gray800
        return label
    }()
    let room: UILabel = {
        let label = UILabel()
        label.font = UIFont.caption1
        label.textColor = UIColor.gray800
        return label
    }()
    private let pinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.locationPin
        return imageView
    }()
    private let errorImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        return flowLayout
    }()
    private lazy var workerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(cell: WorkerCollectionViewCell.self,
            forCellWithReuseIdentifier: WorkerCollectionViewCell.className)
        return collectionView
    }()
    private lazy var roomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pinImage,room])
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [errorImage,time])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    lazy var mainBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        return view
    }()
    lazy var shadowLayer = ShadowView()

    // MARK: - life cycle
    
    override func render(){
        self.addSubview(shadowLayer)
        shadowLayer.addSubview(mainBackground)
        mainBackground.addSubviews(workLabel,workerCollectionView,timeStackView,roomStackView)
        
        mainBackground.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.bottom.equalToSuperview().inset(2)
        }
        shadowLayer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        pinImage.snp.makeConstraints {
            $0.width.height.equalTo(18)
        }
        
        workLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().offset(SizeLiteral.componentPadding)
        }
        
        workerCollectionView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().offset(SizeLiteral.componentPadding)
            $0.height.equalTo(24)
            $0.width.equalTo(190)
        }

        timeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(SizeLiteral.componentPadding)
            $0.trailing.equalToSuperview().inset(SizeLiteral.componentPadding)
        }
        
        roomStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(SizeLiteral.componentPadding)
            $0.trailing.equalToSuperview().inset(SizeLiteral.componentPadding)
        }
    }
    
    override func configUI() {
        self.mainBackground.layer.cornerRadius = 8
        self.mainBackground.layer.borderWidth = 1
        self.mainBackground.layer.borderColor = UIColor.positive10.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.shadowLayer.layoutSubviews()
        self.mainBackground.snp.updateConstraints {
            $0.bottom.equalToSuperview().inset(2)
        }
        self.mainBackground.layer.cornerRadius = 8
        self.mainBackground.layer.borderWidth = 1
        self.mainBackground.layer.borderColor = UIColor.positive10.cgColor
        self.mainBackground.backgroundColor = .white
        self.workLabel.text = String()
        self.errorImage.image = UIImage()
        self.time.text = String()
        self.room.text = String()
    }
    
    func setErrorImageView() {
        self.errorImage.image = ImageLiterals.error
    }
}

extension CalendarDailyTableViewCell: UICollectionViewDelegate {}

extension CalendarDailyTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkerCollectionViewCell.className, for: indexPath) as? WorkerCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        // MARK: - api 연결 시 수정
        cell.workerIconImage.image = ImageLiterals.profilePink1
        return cell
    }
}
