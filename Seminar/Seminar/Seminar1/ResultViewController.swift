//
//  ResultViewController.swift
//  Seminar
//
//  Created by 고아라 on 2023/10/07.
//

import UIKit

class ResultViewController: UIViewController {
    
    var delegate: GetDataProtocol?
    var loginDataCompletion: ((([String]) -> Void))?
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var email: String = ""
    var password: String = ""

    private func bindText() {
        self.emailLabel.text = "email : \(email)"
        self.passwordLabel.text = "password : \(password)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindText()
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        delegate?.getLoginData(email: self.email,
                                       password: self.password)
        guard let loginDataCompletion else {return}
        loginDataCompletion([self.email, self.password])
    }
    
    func setLabelText(id: String,
                          password: String) {
        self.email = id
        self.password = password
    }

}
