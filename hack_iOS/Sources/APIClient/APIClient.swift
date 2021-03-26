//
//  APIClient.swift
//  hack_iOS
//
//  Created by 山根大生 on 2021/03/10.
//

import Foundation
import RxSwift
import RxCocoa

struct APIClient {
    
    func request<T: Requestable>(_ requestable: T) -> Single<T.Response> {
        Single<T.Response>.create { observer in
            guard let request = requestable.urlRequest else {
                fatalError("Request Error")
            }
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error {
                    observer(.failure(APIError.unknown(error)))
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    observer(.failure(APIError.noResponse))
                    return
                }
                // TODO どんなエラーが返ってくるかについてサーバーチームと要相談
                if case 200..<300 = response.statusCode {
                    do {
                        let model = try requestable.decode(from: data)
                        observer(.success(model))
                    } catch let decodeError {
                        observer(.failure(APIError.decode(decodeError)))
                    }
                } else {
                    observer(.failure(APIError.network(response.statusCode)))
                }
            })
            task.resume()
            return Disposables.create()
        }
    }
}

enum APIError: Error {
    case network(Int)
    case decode(Error)
    case noResponse
    case unknown(Error)
}
