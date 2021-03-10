//
//  LoginRequest.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct LoginRequest: Requestable{
    typealias Response = Void
    
    var login: Login?
    
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
        guard let login = login else {
            return nil
        }
        let body: [String: Any] = ["username": login.username]
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func decode(from data: Data) throws -> Void {
        return
    }
}

