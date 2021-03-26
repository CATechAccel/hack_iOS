//
//  LoginViewController.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/09.
//

import UIKit
import RxSwift
import RxCocoa

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
        }
    }
    
    @IBOutlet private weak var moveToSignUpViewButton: UIButton! {
        didSet {
            moveToSignUpViewButton.setTitle("SignupView", for: .normal)
        }
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel: LoginViewModelType
    
    init(
        authRepository: AuthRepository = .init(),
        keychainAccessRepository: KeychainAccessRepository = .init()
    ){
        self.viewModel = LoginViewModel(
            dependency: .init(authrepository: authRepository, keychainAccessRepository: keychainAccessRepository)
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        //input
        userNameTextField.rx.text.orEmpty.asObservable()
            .bind(to: viewModel.input.username)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty.asObservable()
            .bind(to: viewModel.input.password)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: Binder(self) { me, _ in
                me.viewModel.input.loginButtonTapped()
            })
            .disposed(by: disposeBag)
        
        //output
        viewModel.output.loginSucceeded.asObservable()
            .bind(to: Binder(self) { me, _ in
                let rootVC = ListViewController()
                let navVC = UINavigationController(rootViewController: rootVC)
                navVC.modalPresentationStyle = .fullScreen
                me.present(navVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        //サインアップ画面へ遷移
        moveToSignUpViewButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] in
                let rootVC = SignUpViewController()
                let navVC = UINavigationController(rootViewController: rootVC)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        return true
    }
}
