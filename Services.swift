//
//  Services.swift
//  ListView
//
//  Created by NigilDharsan on 05/12/22.
//

import Foundation
// MARK: - Resource
struct Resource {
    let url: URL
    let method: String = "GET"
}

// MARK: - GenericResult
enum Result<T> {
    case success(T)
    case failure(Error)
}

// MARK: - APIClient

enum APIClientError: Error {
    case noData
}

// MARK: - URLRequest
extension URLRequest {
    
    init(_ resource: Resource) {
        self.init(url: resource.url)
        self.httpMethod = resource.method
    }
    
}


// MARK: - URLSession APICall

final class APIClient {
    
    func load(_ resource: Resource, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(resource)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                result(.failure(APIClientError.noData))
                return
            }
            if let error = error {
                result(.failure(error))
                return
            }
            result(.success(data))
        }
        task.resume()
    }
    
}
