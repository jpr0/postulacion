//
//  ApiClient.swift
//  ItunesPagerApp
//
//  Created by Juan Pablo on 29-01-20.
//  Copyright © 2020 Juan Pablo. All rights reserved.
//

import Foundation
import RxSwift

enum ApiError: Error {
    case decoded
    case invalidUrl
    case invalidQueryItems
}

protocol ApiClient {
    func request<Response: Decodable>(_ endpoint: Endpoint<Response>) -> Single<Response>
}

class RestClient {
    private let manager: URLSession
    private let url: URL

    init(manager: URLSession, url: URL) {
        self.manager = manager
        self.url = url
    }
}
extension RestClient : ApiClient {
    func request<Response: Decodable>(_ endpoint: Endpoint<Response>) -> Single<Response> {
        return Single.create { observer in
            let task = self.request(endpoint) { result in
                switch result {
                case .success(let decodable):
                    observer(.success(decodable))
                case .failure(let error):
                    observer(.error(error))
                }
            }

            return Disposables.create {
                task?.cancel()
            }
        }
    }
    private func request<Response: Decodable>(_ endpoint: Endpoint<Response>, result: @escaping(Result<Response, Error>) -> ()) -> URLSessionDataTask? {

        guard var urlComponents = URLComponents(url: url.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true) else {
            result(.failure(ApiError.invalidUrl))
            return nil
        }

        urlComponents.queryItems = endpoint.queryItems

        guard let url = urlComponents.url else {
            result(.failure(ApiError.invalidQueryItems))
            return nil
        }

        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = endpoint.headers
        request.httpMethod = endpoint.method.rawValue

        if endpoint.method != .get {
            request.httpBody = endpoint.parameters?.encoded
        }

        print("URL: \(url)")

        let task = manager.dataTask(with: request) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }

            guard let data = data, let decoded = try? endpoint.decode(data) else {
                result(.failure(ApiError.decoded))
                return
            }

            result(.success(decoded))
        }
        
        task.resume()
        
        return task
    }
}

