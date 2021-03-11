//
//  AddTaskRequest.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct AddTaskRequest: Requestable {
    typealias Response = Void
    
    var addTask: AddTask?
    
    var url: String {
        // TODO
        return ""
    }
    
    var httpMethod: String {
        return "POST"
    }
    
    var headers: [String : String] {
        // TODO
        return [:]
    }
    
    var body: Data? {
        guard let addTask = addTask else {
            return nil
        }
        let body: [String: Any] = [
            "name": addTask.name,
            "description": addTask.description
        ]
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func decode(from data: Data) throws -> Void {
        return
    }
}
