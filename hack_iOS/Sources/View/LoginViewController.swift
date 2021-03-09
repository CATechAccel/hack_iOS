//
//  LoginViewController.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/09.
//

import UIKit

final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var userNameTextField: UITextField! {
        didSet {
            userNameTextField.placeholder = "ユーザー名を入力"
            userNameTextField.delegate = self
        }
    }
    @IBOutlet private weak var loginButton: UIButton! {
        didSet {
            loginButton.setTitle("LOGIN", for: .normal)
            loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func tapLoginButton() {
        let rootVC = ListViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        return true
    }
}
