//
//  ImageCollectionViewCell.swift
//  Seminar
//
//  Created by 고아라 on 2023/10/28.
//

import UIKit

import SnapKit

protocol ItemSelectedProtocol: NSObject {
    func getButtonState(state: Bool, row: Int)
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ImageCollectionViewCell"
    
    weak var delegate: ItemSelectedProtocol?
    var itemRow: Int?
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var likeButton: UIButton = {
        lazy var button = UIButton()
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .selected)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierachy()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageCollectionViewCell {
    func setHierachy() {
        [imageView, likeButton].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    func setAddTarget() {
        self.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func likeButtonTapped() {
        self.likeButton.isSelected.toggle()
        if let itemRow {
            self.delegate?.getButtonState(state: self.likeButton.isSelected,
                                          row: itemRow)
        }
    }
    
    func setDataBind(data: ImageCollectionData, row: Int) {
        self.imageView.image = UIImage(named: data.image)
        self.likeButton.isSelected = data.isLiked
        self.itemRow = row
    }
}
