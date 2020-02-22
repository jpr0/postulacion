//
//  API.swift
//  ItunesPagerApp
//
//  Created by Juan Pablo on 29-01-20.
//  Copyright © 2020 Juan Pablo. All rights reserved.
//

import Foundation

struct Throwable<T: Decodable>: Decodable {
    let result: Result<T, Error>

    init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }
}

struct Track: Decodable {
    let wrapperType: String
    let collectionId: Int
    let trackId: Int
    let artistName: String
    let collectionName: String
    let trackName: String
    let previewUrl: String
    let artworkUrl100: String
}

struct SearchTerms: Payload {
    let terms: String

    var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "term", value: "\(terms)"),
            URLQueryItem(name: "mediaType", value: "music"),
        ]
    }
}

struct SearchAlbum: Payload {
    let id: Int

    var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "id", value: "\(id)"),
            URLQueryItem(name: "entity", value: "song")
        ]
    }
}

struct NestedResult<T: Decodable>: Decodable {
    let results: T
}

enum API {
    private static func headers(for payload: Payload) -> Headers? {
        return ["Content-Length": "\(payload.encoded?.count ?? 0)"]
    }

    enum Media {
        static func searchTracks(by payload: SearchTerms) -> Endpoint<NestedResult<[ArtistModel]>> {
            return Endpoint(method: .get, path: "/search", headers: headers(for: payload), parameters: payload) { data in
                let throwables = try JSONDecoder().decode(NestedResult<[Throwable<ArtistModel>]>.self, from: data)
                let products = throwables.results.compactMap { try? $0.result.get() }

                return NestedResult<[ArtistModel]>(results: products)
            }
        }

        static func findAlbum(by payload: SearchAlbum) -> Endpoint<NestedResult<[Track]>> {
            return Endpoint(path: "/lookup", headers: headers(for: payload), parameters: payload)
        }
    }
}
