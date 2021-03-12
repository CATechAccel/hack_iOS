//
//  Repository.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

protocol Repository {
    associatedtype Response
    var apiClient: APIClient { get }

    func fetch(completion: @escaping (Result<Response, APIError>) -> Void)
    func post(postDictionary: [String: Any?], completion: @escaping (Result<Void, APIError>) -> Void)
    func done(doneDictionary: [String: Any?], completion: @escaping (Result<Void, APIError>) -> Void)
}
