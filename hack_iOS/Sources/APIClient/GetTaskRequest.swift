//
//  GetTaskRequest.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct GetTaskRequest: Requestable{
    typealias Response = Task
    
    var url: String {
        // TODO
        return ""
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var body: Data?
    
    var headers: [String : String] {
        // TODO
        return [:]
    }
    
    func decode(from data: Data) throws -> Task {
        let decoder = JSONDecoder()
        return try decoder.decode(Task.self, from: data)
    }
}
