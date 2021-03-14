//
//  UserRequest.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct UserRequest: Requestable {
    typealias Response = Void
    
    let username: String
    let password: String
    
    var url: String {
        // TODO
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return HTTPMethod.POST
    }
    
    var headers: [String: String] {
        // TODO
        return [:]
    }
    
    var body: Data? {
        let body: [String: Any] = [
            "username": username,
            "password": password
        ]
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func decode(from data: Data) throws -> Void {
        return
    }
}

