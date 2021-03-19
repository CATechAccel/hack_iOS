//
//  TaskRequest.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct TaskRequest: Requestable {
    typealias Response = [Task]
    
    private let repository = KeychainAccessRepository()
    
    var url: String {
        // TODO
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .GET
    }
    
    var body: Data?
    
    var headers: [String: String] {
        return ["Authorization":"Bearer \(repository.get() ?? "" )"]
    }
    
    func decode(from data: Data) throws -> [Task] {
        let decoder = JSONDecoder()
        return try decoder.decode([Task].self, from: data)
    }
}
