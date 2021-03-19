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
    
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.placeholder = "パスワードを入力"
            passwordTextField.delegate = self
        }
    }
    
    @IBOutlet private weak var loginButton: UIButton! {
        didSet {
            loginButton.setTitle("Login", for: .normal)
            loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        }
    }
    
    @IBOutlet private weak var moveToSignUpViewButton: UIButton! {
        didSet {
            moveToSignUpViewButton.setTitle("SignupView", for: .normal)
            moveToSignUpViewButton.addTarget(self, action: #selector(tapMoveToSignUpViewButton), for: .touchUpInside)
        }
    }
    
    init(userRepository: UserRepository = .init()) {
        self.userRepository = userRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let userRepository: UserRepository
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func tapLoginButton() {
        login()
    }
    
    @objc private func tapMoveToSignUpViewButton() {
        let rootVC = SignUpViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        return true
    }
    
    private func login() {
        guard
            let username = userNameTextField.text,
            let password = passwordTextField.text
        else {
            return
        }
        
        let dict: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        userRepository.post(postDictionary: dict, completion: { [weak self] result in
            switch result {
            case .failure(let error):
                switch error {
                case .decode(let error):
                    print(error)
                case .network(let error):
                    print(error)
                case .unknown(let error):
                    print(error)
                case .noResponse:
                    print("No Response")
                }
            case .success(()):
                let rootVC = ListViewController()
                let navVC = UINavigationController(rootViewController: rootVC)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true)
            }
        })
    }
}
