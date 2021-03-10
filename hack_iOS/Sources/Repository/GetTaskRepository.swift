//
//  GetTaskRepository.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct GetTaskRepository: Repository {
    typealias Response = Task
    
    var apiClient: APIClient
    
    func fetch(completion: @escaping (Result<Task, APIError>) -> Void) {
        let request = GetTaskRequest()
        apiClient.request(request, completion: completion)
    }
}
