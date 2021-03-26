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
    
    let taskIDs: [String]
    
    var url: String {
        // TODO
        return "https://hack-ios-server-kacg6ymbjq-uc.a.run.app/tasks/done"
    }
    
    var httpMethod: HTTPMethod {
        return HTTPMethod.POST
    }
    
    var headers: [String: String] {
        return ["Authorization":"Bearer \(repository.get() ?? "" )"]
    }
    
    var body: Data? {
        let body: [String: Any] = [
            "taskIds": taskIDs
        ]
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    func decode(from data: Data) throws -> Void {
        return
    }
}

