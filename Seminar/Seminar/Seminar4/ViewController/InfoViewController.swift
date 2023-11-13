//
//  InfoViewController.swift
//  Seminar
//
//  Created by 고아라 on 2023/11/11.
//

import UIKit

import SnapKit

final class InfoViewController: UIViewController {
    
    // MARK: - Properties
    
    private var userId: String = ""
    
    // MARK: - UI Components
    
    private let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.spacing = 20
        return stackview
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.placeholder = "검색할 유저 아이디를 입력하세요"
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("검색", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setHierachy()
        setLayout()
        setAddTarget()
    }
}

// MARK: - Extensions
private extension InfoViewController {
    func setHierachy() {
        [idTextField, infoLabel, searchButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
        self.view.addSubview(stackView)
    }
    
    func setLayout() {
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(200)
        }
        
        [idTextField, searchButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(40)
            }
        }
    }
    
    func setAddTarget() {
        idTextField.addTarget(self, action: #selector(textFieldDidEditing(_:)), for: .allEvents)
        searchButton.addTarget(self, action: #selector(searchButtonTap), for: .touchUpInside)
    }
    
    @objc
    func textFieldDidEditing(_ textField: UITextField) {
        self.userId = textField.text ?? ""
    }
    
    @objc
    func searchButtonTap() {
        Task {
            if let result = try await GetInfoService.shared.PostRegisterData(userId: Int(self.userId) ?? 1) {
                self.infoLabel.text = "userName: \(result.username)\nnickName: \(result.nickname)"
            }
        }
    }
}
