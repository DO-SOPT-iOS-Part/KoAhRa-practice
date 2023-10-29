//
//  ImageViewController.swift
//  Seminar
//
//  Created by 고아라 on 2023/10/28.
//

import UIKit

import SnapKit

final class ImageViewController: UIViewController {
    
    var imageCollectionList: [ImageCollectionData] = [.init(image: "image1", isLiked: true),
                                                      .init(image: "image2", isLiked: true),
                                                      .init(image: "image3", isLiked: false),
                                                      .init(image: "image4", isLiked: false),
                                                      .init(image: "image5", isLiked: true),
                                                      .init(image: "image6", isLiked: false),
                                                      .init(image: "image7", isLiked: true),
                                                      .init(image: "image8", isLiked: false),
                                                      .init(image: "image1", isLiked: false),
                                                      .init(image: "image2", isLiked: false),
                                                      .init(image: "image3", isLiked: true),
                                                      .init(image: "image4", isLiked: false),
                                                      .init(image: "image5", isLiked: true),
                                                      .init(image: "image6", isLiked: true),
                                                      .init(image: "image7", isLiked: false),
                                                      .init(image: "image8", isLiked: false),
                                                      .init(image: "image1", isLiked: false),
                                                      .init(image: "image2", isLiked: false),
                                                      .init(image: "image3", isLiked: false),
                                                      .init(image: "image4", isLiked: false),
                                                      .init(image: "image5", isLiked: false),
                                                      .init(image: "image6", isLiked: false),
                                                      .init(image: "image7", isLiked: false),
                                                      .init(image: "image8", isLiked: false),
                                                      .init(image: "image1", isLiked: true),
                                                      .init(image: "image2", isLiked: true),
                                                      .init(image: "image3", isLiked: false),
                                                      .init(image: "image4", isLiked: false),
                                                      .init(image: "image5", isLiked: false),
                                                      .init(image: "image6", isLiked: false),
                                                      .init(image: "image7", isLiked: false),
                                                      .init(image: "image8", isLiked: false),
                                                      .init(image: "image1", isLiked: true),
                                                      .init(image: "image2", isLiked: false),
                                                      .init(image: "image3", isLiked: false),
                                                      .init(image: "image4", isLiked: true),
                                                      .init(image: "image5", isLiked: false),
                                                      .init(image: "image6", isLiked: false),
                                                      .init(image: "image7", isLiked: true),
                                                      .init(image: "image8", isLiked: true)]

    private let collectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionview.backgroundColor = .black
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierachy()
        setLayout()
        setRegister()
        setDelegate()
    }
}

extension ImageViewController {
    func setHierachy() {
        self.view.addSubview(collectionView)
    }
    
    func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setRegister() {
        self.collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    func setDelegate() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension ImageViewController: UICollectionViewDelegate {
    
}

extension ImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {return UICollectionViewCell()}
        item.delegate = self
        item.setDataBind(data: imageCollectionList[indexPath.item], row: indexPath.row)
        return item
    }
}

extension ImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 6) / 3 , height: (UIScreen.main.bounds.width - 6) / 3)
    }
}

extension ImageViewController: ItemSelectedProtocol {
    func getButtonState(state: Bool, row: Int) {
        imageCollectionList[row].isLiked = state
    }
}
