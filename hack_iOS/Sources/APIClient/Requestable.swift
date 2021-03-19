//
//  Requestable.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/10.
//

import Foundation

protocol Requestable {
    associatedtype Response
    var url: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    
    func decode(from data: Data) throws -> Response
}

extension Requestable {
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let body = body {
            request.httpBody = body
        }
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
