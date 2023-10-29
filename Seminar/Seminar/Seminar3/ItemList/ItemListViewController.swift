//
//  ItemListViewController.swift
//  Seminar
//
//  Created by 고아라 on 2023/10/28.
//

import UIKit

import SnapKit

final class ItemListViewController: UIViewController {
    
    var itemListData: [ItemListData] = [.init(image: "image1",
                                              item: "외장하드",
                                              location: "노원구 중계2.3동",
                                              price: "60,000원",
                                              isLike: false),
                                        .init(image: "image2",
                                              item: "게이밍 의자",
                                              location: "노원구 상계 8동",
                                              price: "30,000원",
                                              isLike: false),
                                        .init(image: "image3",
                                              item: "노트북 팝니다",
                                              location: "노원구 상계9동",
                                              price: "120,000원",
                                              isLike: true),
                                        .init(image: "image4",
                                              item: "닌텐도 이카드 리더기 이사가야해서 잡동사니 급처해요 아무나 사가주시면 너무 감사할거같은데 그쪽도 자겁치까를 아세요?",
                                              location: "의정부시 송산2동",
                                              price: "50,000원",
                                              isLike: true),
                                        .init(image: "image1",
                                              item: "외장하드",
                                              location: "노원구 중계2.3동",
                                              price: "60,000원",
                                              isLike: false),
                                        .init(image: "image2",
                                              item: "게이밍 의자",
                                              location: "노원구 상계 8동",
                                              price: "30,000원",
                                              isLike: false),
                                        .init(image: "image3",
                                              item: "노트북 팝니다",
                                              location: "노원구 상계9동",
                                              price: "120,000원",
                                              isLike: true),
                                        .init(image: "image4",
                                              item: "닌텐도 이카드 리더기 이사가야해서 잡동사니 급처해요 아무나 사가주시면 너무 감사할거같은데 그쪽도 자겁치까를 아세요?",
                                              location: "의정부시 송산2동",
                                              price: "50,000원",
                                              isLike: true)]
    
    private let tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.separatorColor = .lightGray
        tableview.separatorStyle = .singleLine
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierachy()
        setLayout()
        setRegister()
        setDelegate()
    }
}

extension ItemListViewController {
    func setHierachy() {
        view.addSubview(tableView)
    }
    
    func setLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setRegister() {
        self.tableView.register(ItemListTableViewCell.self, forCellReuseIdentifier: ItemListTableViewCell.identifier)
    }
    
    func setDelegate() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension ItemListViewController : UITableViewDelegate {
}

extension ItemListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier, for: indexPath) as? ItemListTableViewCell else {return UITableViewCell()}
        cell.likeTapCompletion = { [weak self] state in
            guard let self else {return}
            itemListData[indexPath.row].isLike = state
        }
        cell.setDataBind(model: itemListData[indexPath.row])
        return cell
    }
}
