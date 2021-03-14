//
//  SignUpViewController.swift
//  hack_iOS
//
//  Created by 化田晃平 on R 3/03/12.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet private weak var userNameTextField: UITextField! {
        didSet {
            userNameTextField.placeholder = "ユーザー名を入力"
            userNameTextField.delegate = self
        }
    }
    
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.placeholder = "パスワードを入力"
            passwordTextField.delegate = self
        }
    }
    
    @IBOutlet private weak var signUpButton: UIButton! {
        didSet {
            signUpButton.setTitle("Signup", for: .normal)
            signUpButton.addTarget(self, action: #selector(tapSignupButton), for: .touchUpInside)
        }
    }
    
    @IBOutlet private weak var moveToLoginViewButton: UIButton! {
        didSet {
            moveToLoginViewButton.setTitle("LoginView", for: .normal)
            moveToLoginViewButton.addTarget(self, action: #selector(tapMoveToLoginViewButton), for: .touchUpInside)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func tapSignupButton() {
        let rootVC = ListViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc private func tapMoveToLoginViewButton() {
        let rootVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        return true
    }
}
