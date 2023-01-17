//
//  CalendarDailyWorkEndCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/14.
//

import UIKit

import SnapKit

final class CalendarDailyWorkEndCollectionViewCell: BaseCollectionViewCell {

    // MARK: - property
    
    var workLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(AppFontName.semiBold, ofSize: 16)
        label.textColor = UIColor.gray800
        return label
    }()
    var time: UILabel = {
        let label = UILabel()
        label.font = UIFont.caption1
        label.textColor = UIColor.gray800
        return label
    }()
    var room: UILabel = {
        let label = UILabel()
        label.font = UIFont.caption1
        label.textColor = UIColor.gray800
        return label
    }()
    let workerImage1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.profileLightBlue1
        imageView.snp.makeConstraints{
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        return imageView
    }()
    let workerImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.profileGreen1
        imageView.snp.makeConstraints{
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        return imageView
    }()
    let workerImage3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.profileLightBlue2
        imageView.snp.makeConstraints{
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        return imageView
    }()
    private let pinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.locationPin
        imageView.snp.makeConstraints{
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }
        return imageView
    }()
    private lazy var workerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [workerImage1,workerImage2,workerImage3])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [workLabel,workerStackView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .leading
        return stackView
    }()
    private lazy var roomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pinImage,room])
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [time,roomStackView])
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .trailing
        return stackView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubviews(leftStackView,rightStackView)
        
        leftStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().offset(SizeLiteral.componentPadding)
        }
        
        rightStackView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(SizeLiteral.componentPadding)
            $0.trailing.equalToSuperview().inset(SizeLiteral.componentPadding)
        }
    }
    
    override func configUI() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.positive10.cgColor
        self.backgroundColor = UIColor.positive10
    }
}
