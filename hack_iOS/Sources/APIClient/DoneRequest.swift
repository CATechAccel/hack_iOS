//
//  DoneRequest.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct DoneRequest: Requestable{
    typealias Response = Void
    
    var done: Done?
    
    var url: String {
        // TODO
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return HTTPMethod.POST
    }
    
    var headers: [String : String] {
        // TODO
        return [:]
    }
    
    var body: Data? {
        guard let done = done else {
            return nil
        }
        let body: [String: Any] = ["id": done.id]
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func decode(from data: Data) throws -> Void {
        return
    }
}

