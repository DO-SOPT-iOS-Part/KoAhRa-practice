//
//  RegisterViewController.swift
//  Seminar
//
//  Created by 고아라 on 2023/11/11.
//

import UIKit

import SnapKit

final class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    private var userName: String = ""
    private var password: String = ""
    private var nickName: String = ""
    
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
        textField.placeholder = "아이디를 입력하슈"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.placeholder = "패스워드를 입력하슈"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.placeholder = "닉네임을 입력하슈"
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var infoViewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("회원정보 조회", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setHierachy()
        setLayout()
        setAddTarget()
    }
}

// MARK: - Extensions
private extension RegisterViewController {
    func setHierachy() {
        [idTextField, passwordTextField, nickNameTextField, registerButton, infoViewButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
        self.view.addSubview(stackView)
    }
    
    func setLayout() {
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(200)
        }
        
        [idTextField, passwordTextField, nickNameTextField, registerButton, infoViewButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(40)
            }
        }
    }
    
    func setAddTarget() {
        idTextField.addTarget(self, action: #selector(textFieldDidEditing(_:)), for: .allEvents)
        passwordTextField.addTarget(self, action: #selector(textFieldDidEditing(_:)), for: .allEvents)
        nickNameTextField.addTarget(self, action: #selector(textFieldDidEditing(_:)), for: .allEvents)
        registerButton.addTarget(self, action: #selector(registerButtonTap), for: .touchUpInside)
        infoViewButton.addTarget(self, action: #selector(infoViewButtonTap), for: .touchUpInside)
    }
    
    @objc
    func textFieldDidEditing(_ textField: UITextField) {
        switch textField {
        case idTextField:
            userName = textField.text ?? ""
        case passwordTextField:
            password = textField.text ?? ""
        default:
            nickName = textField.text ?? ""
        }
    }
    
    @objc
    func registerButtonTap() {
        Task {
            do {
                let status = try await RegisterService.shared.PostRegisterData(userName: self.userName, password: self.password, nickName: self.nickName)
                let checkExist = try await CheckService.shared.PostCheck(username: idTextField.text ?? "")
                if status == 201 {
                    let alert = UIAlertController(title: "계정생성 성공", message: "와하하", preferredStyle: UIAlertController.Style.alert)
                    let okAction =  UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "계정생성 실패", message: "흑흑", preferredStyle: UIAlertController.Style.alert)
                    let okAction =  UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
                    alert.addAction(okAction)
                    print(checkExist?.isExist ?? "")
                    self.present(alert, animated: true)
                }
            } catch {
                print(error)
            }
        }
    }
    
    @objc
    func infoViewButtonTap() {
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true)
    }
}
