//
//  APIClient.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/10.
//

import Foundation

struct APIClient {
    let decoder: JSONDecoder
    
    func request<T: Requestable>(_ requestable: T, completion: @escaping (Result<T.Response, APIError>) -> Void) {
        guard let request = requestable.urlRequest else { return }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(APIError.unknown(error)))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(APIError.noResponse))
                return
            }
            // TODO どんなエラーが返ってくるかについてサーバーチームと要相談
            if case 200..<300 = response.statusCode {
                do {
                    let model = try requestable.decode(from: data)
                    completion(.success(model))
                } catch let decodeError {
                    completion(.failure(APIError.decode(decodeError)))
                }
            } else {
                completion(.failure(APIError.network(response.statusCode)))
            }
        })
        task.resume()
    }
}

enum APIError: Error {
    case network(Int)
    case decode(Error)
    case noResponse
    case unknown(Error)
}
