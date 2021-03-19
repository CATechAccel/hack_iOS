//
//  AddTaskRequest.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct AddTaskRequest: Requestable {
    typealias Response = Void
    
    let name: String
    let description: String
    
    var url: String {
        // TODO
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .POST
    }
    
    var headers: [String: String] {
        // TODO
        return [:]
    }
    
    var body: Data? {
        let body: [String: Any] = [
            "name": name,
            "description": description
        ]
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func decode(from data: Data) throws -> Void {
        return
    }
}
