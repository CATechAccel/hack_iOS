//
//  SignUpViewController.swift
//  hack_iOS
//
//  Created by 化田晃平 on R 3/03/12.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
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
    
    private let authRepository: AuthRepository
    private let keychainAccessRepository: KeychainAccessRepository
    
    init(authRepository: AuthRepository = .init(), keychainAccessRepository: KeychainAccessRepository = .init()) {
        self.keychainAccessRepository = keychainAccessRepository
        self.authRepository = authRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func tapSignupButton() {
        signup()
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
    
    private func signup() {
        guard
            let username = userNameTextField.text,
            let password = passwordTextField.text
        else {
            return
        }        
        
        authRepository.signup(username: username, password: password, completion: { [weak self] result in
            guard let me = self else { return }
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
            case .success(let token):
                me.keychainAccessRepository.save(token: token)
                let rootVC = ListViewController()
                let navVC = UINavigationController(rootViewController: rootVC)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true)
            }
        })
    }
}
