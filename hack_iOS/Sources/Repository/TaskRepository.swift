//
//  GetTaskRepository.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation
import RxSwift
import RxCocoa

struct TaskRepository: Repository {
    typealias Response = TaskSource
    let apiClient = APIClient()
    
    func fetch() -> Single<Response> {
        let request = TaskRequest()
        return apiClient.request(request)
    }
    
    func post(name: String, description: String?) -> Single<Void> {
        let request = AddTaskRequest(name: name, description: description)
        return apiClient.request(request)
    }
    
    func done(id: String) -> Single<Void> {
        let request = DoneRequest(id: id)
        return apiClient.request(request)
    }
}
