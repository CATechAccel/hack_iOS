//
//  UserRepository.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/12.
//

import Foundation

struct UserRepository: Repository {
    typealias Response = Token
    let apiClient = APIClient()

    func login(username: String,password: String, completion: @escaping (Result<Response, APIError>) -> Void) {
        let request = AuthRequest(username: username, password: password, type: .login)
        apiClient.request(request, completion: completion)
        return
    }
    
    func signup(username: String,password: String, completion: @escaping (Result<Response, APIError>) -> Void) {
        let request = AuthRequest(username: username, password: password, type: .signup)
        apiClient.request(request, completion: completion)
        return
    }
}
