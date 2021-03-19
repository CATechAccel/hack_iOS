//
//  AuthRequest.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

enum AuthType {
    case login
    case signup
}

struct AuthRequest: Requestable {
    typealias Response = String
    
    let username: String
    let password: String
    
    let type: AuthType
    
    var url: String {
        switch type {
        case .login:
            return "/login"
        case .signup:
            return "/users"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .POST
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var body: Data? {
        let body: [String: Any] = [
            "username": username,
            "password": password
        ]
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func decode(from data: Data) throws -> String {
        let decoder = JSONDecoder()
        return try decoder.decode(String.self, from: data)
    }
}
