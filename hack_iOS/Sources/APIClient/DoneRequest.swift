//
//  DoneRequest.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/11.
//

import Foundation

struct DoneRequest: Requestable {
    typealias Response = Void
    
    private let repository = KeychainAccessRepository()
    
    let id: String
    
    var url: String {
        // TODO
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return HTTPMethod.POST
    }
    
    var headers: [String: String] {
        return ["Authorization":"Bearer \(repository.get() ?? "" )"]
    }
    
    var body: Data? {
        let body: [String: Any] = [
            "id": id
        ]
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func decode(from data: Data) throws -> Void {
        return
    }
}

