//
//  GetTaskRepository.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct TaskRepository: Repository {
    typealias Response = TaskSource
    let apiClient = APIClient()
    
    func fetch(completion: @escaping (Result<Response, APIError>) -> Void) {
        let request = TaskRequest()
        apiClient.request(request, completion: completion)
    }
    
    func post(name: String, description: String?, completion: @escaping (Result<Void, APIError>) -> Void) {
        let request = AddTaskRequest(name: name, description: description)
        apiClient.request(request, completion: completion)
    }
    
    func done(id: String, completion: @escaping (Result<Void, APIError>) -> Void) {
        let request = DoneRequest(id: id)
        apiClient.request(request, completion: completion)
    }
}
