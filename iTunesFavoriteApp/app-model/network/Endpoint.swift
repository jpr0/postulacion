//
//  Endpoint.swift
//  ItunesPagerApp
//
//  Created by Juan Pablo on 29-01-20.
//  Copyright © 2020 Juan Pablo. All rights reserved.
//

import Foundation

enum Method : String {
    case get, post
}

typealias Headers = [String : String]
typealias Path = String

protocol Payload : Encodable {
    var queryItems: [URLQueryItem]? { get }
    var encoded: Data? { get }
}
extension Payload {
    var encoded: Data? {
        return try? JSONEncoder().encode(self)
    }
}

class Endpoint<T> {
    let method: Method
    let path: Path
    let parameters: Payload?
    let decode: (Data) throws -> T?

    var headers: Headers?
    
    var queryItems: [URLQueryItem] {
        guard let items = parameters?.queryItems else {
            return []
        }

        return items
    }
    
    init(method: Method, path: Path, headers: Headers?, parameters: Payload?, decode: @escaping (Data) throws -> T?) {
        self.method = method
        self.path = path
        self.headers = headers
        self.parameters = parameters
        self.decode = decode
    }
}

extension Endpoint where T: Swift.Decodable {
    convenience init(method: Method = .get, path: Path, headers: Headers? = Headers(), parameters: Payload? = nil) {
        self.init(method: method, path: path, headers: headers, parameters: parameters, decode: {
            return try JSONDecoder().decode(T.self, from: $0)
        })
    }
}
