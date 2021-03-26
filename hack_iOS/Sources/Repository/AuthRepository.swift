//
//  AuthRepository.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/12.
//

import Foundation
import RxSwift
import RxCocoa

struct AuthRepository: Repository {
    typealias Response = [String: String]
    let apiClient = APIClient()

    func login(username: String,password: String) -> Single<Response> {
        let request = AuthRequest(username: username, password: password, type: .login)
        return apiClient.request(request)
    }
    
    func signup(username: String,password: String) -> Single<Response> {
        let request = AuthRequest(username: username, password: password, type: .signup)
        return apiClient.request(request)
    }
}
