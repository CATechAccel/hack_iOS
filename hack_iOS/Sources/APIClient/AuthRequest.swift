//
//  AuthRequest.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation
import CryptoSwift

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
            return "https://hack-ios-server-kacg6ymbjq-uc.a.run.app/login"
        case .signup:
            return "https://hack-ios-server-kacg6ymbjq-uc.a.run.app/users"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .POST
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var body: Data? {
        let hashedPassword = password.sha256()
        let body: [String: Any] = [
            "username": username,
            "password": hashedPassword
        ]
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func decode(from data: Data) throws -> String {
        let decoder = JSONDecoder()
        return try decoder.decode(String.self, from: data)
    }
}

