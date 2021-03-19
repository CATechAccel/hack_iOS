//
//  GetTaskRepository.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct TaskRepository: Repository {
    typealias Response = [Task]
    let apiClient = APIClient()
    
    func fetch(completion: @escaping (Result<Response, APIError>) -> Void) {
        let request = TaskRequest()
        apiClient.request(request, completion: completion)
    }
    
    func post(postDictionary: [String: Any?], completion: @escaping (Result<Void, APIError>) -> Void) {
        guard let name = postDictionary["name"] as? String, let description  = postDictionary["discription"] as? String else { return }
        let request = AddTaskRequest(name: name, description: description)
        apiClient.request(request, completion: completion)
    }
    
    func done(doneDictionary: [String: Any?], completion: @escaping (Result<Void, APIError>) -> Void) {
        guard let id = doneDictionary["id"] as? String else { return }
        let request = DoneRequest(id: id)
        apiClient.request(request, completion: completion)
    }
}
