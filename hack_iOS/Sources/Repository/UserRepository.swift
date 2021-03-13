//
//  UserRepository.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/12.
//

import Foundation

struct UserRepository: Repository {
    typealias Response = Void
    let apiClient = APIClient()

    func post(postDictionary: [String: Any?], completion: @escaping (Result<Void, APIError>) -> Void) {
        guard
            let username = postDictionary["username"] as? String,
            let password = postDictionary["password"] as? String
        else { return }
        
        let request = UserRequest(username: username, password: password)
        apiClient.request(request, completion: completion)
        return
    } 
}
