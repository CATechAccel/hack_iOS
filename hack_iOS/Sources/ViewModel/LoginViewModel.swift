//
//  LoginViewModel.swift
//  hack_iOS
//
//  Created by 化田晃平 on R 3/03/26.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewModelType {
    var input: LoginViewModelInput { get }
    var output: LoginViewModelOutput { get }
}

protocol LoginViewModelInput {
    var username: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
    func loginButtonTapped()
    func moveToSignUpButtonTapped()
}

protocol LoginViewModelOutput {
    var loginSucceeded: Signal<Void> { get }
}

final class LoginViewModel: LoginViewModelType, LoginViewModelInput, LoginViewModelOutput {
    
    struct Dependency {
        var authrepository: AuthRepository
        var keychainAccessRepository: KeychainAccessRepository
    }
    
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    private let loginButtonTappedRelay = PublishRelay<Void>()
    private let moveToSignUpButtonTappedRelay = PublishRelay<Void>()
    
    private let loginSucceededRelay = PublishRelay<Void>()
    var loginSucceeded: Signal<Void> {
        loginSucceededRelay.asSignal()
    }
    
    private let dependency: Dependency
    private let disposeBag = DisposeBag()
    
    var input: LoginViewModelInput { self }
    var output: LoginViewModelOutput { self }
    
    init(dependency: Dependency) {
        self.dependency = dependency
        
        let loginEvent = loginButtonTappedRelay.asObservable()
            .withLatestFrom(username)
            .withLatestFrom(password) { ($0, $1) } // optionalの場合はエラーを吐く....
            .filter { username, password in
                !username.isEmpty && !password.isEmpty
            }
            .flatMap { username, password in
                dependency.authrepository.login(username: username, password: password)
                    .asObservable().materialize()
            }
            .share()
            
        loginEvent
            .flatMap { $0.element.map(Observable.just) ?? .empty() }
            .subscribe( Binder(self) { me, token in
                guard let authToken = token["token"] else { return }
                me.dependency.keychainAccessRepository.save(token: authToken)
                me.loginSucceededRelay.accept(())
            })
            .disposed(by: disposeBag)
        
        loginEvent
            .flatMap { $0.error.map(Observable.just) ?? .empty() }
            .subscribe( Binder(self) { _, error in
                guard let error = error as? APIError else { return }
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
            })
            .disposed(by: disposeBag)
    }
    
    func loginButtonTapped() { loginButtonTappedRelay.accept(()) }
    func moveToSignUpButtonTapped() { moveToSignUpButtonTappedRelay.accept(()) }
}
