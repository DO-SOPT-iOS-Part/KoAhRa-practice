//
//  ItemListTableViewCell.swift
//  Seminar
//
//  Created by 고아라 on 2023/10/28.
//

import UIKit

import SnapKit

class ItemListTableViewCell: UITableViewCell {
    
    static let identifier: String = "ItemListTableViewCell"
    
    var likeTapCompletion: ((Bool) -> Void)?
    
    private let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.spacing = 8
        return stackview
    }()
    
    private let productImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.textColor = .black
        return label
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierachy()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.likeButton.isSelected = false
    }
}

extension ItemListTableViewCell {
    func setHierachy() {
        [productLabel, locationLabel, priceLabel].forEach {
            self.stackView.addArrangedSubview($0)
        }
        
        [productImage, stackView, likeButton].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func setLayout() {
        productImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(128)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(productImage.snp.trailing).offset(16)
            $0.top.trailing.equalToSuperview().inset(16)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(productImage.snp.bottom)
            $0.trailing.bottom.equalToSuperview().inset(16)
        }
        
    }
    
    func setAddTarget() {
        self.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func likeButtonTapped() {
        likeButton.isSelected.toggle()
        guard let likeTapCompletion else {return}
        likeTapCompletion(likeButton.isSelected)
    }
    
    func setDataBind(model: ItemListData) {
        self.productImage.image = UIImage(named: model.image)
        self.productLabel.text = model.item
        self.priceLabel.text = model.price
        self.locationLabel.text = model.location
        self.likeButton.isSelected = model.isLike
    }
}
