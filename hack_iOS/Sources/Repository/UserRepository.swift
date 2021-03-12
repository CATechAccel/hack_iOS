//
//  UserRepository.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/12.
//

import Foundation

struct UserRepository: Repository {
    typealias Response = Void
    var apiClient: APIClient
    
    func fetch(completion: @escaping (Result<Void, APIError>) -> Void) {
        return
    }
    
    func post(postDictionary: [String: Any?], completion: @escaping (Result<Void, APIError>) -> Void) {
        guard let username = postDictionary["username"] as? String else { return }
        let request = UserRequest(username: username)
        apiClient.request(request, completion: completion)
        return
    }
    
    func done(doneDictionary: [String: Any?], completion: @escaping (Result<Void, APIError>) -> Void) {
        return
    }    
}
