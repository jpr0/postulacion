//
//  RemoteArtistRepository.swift
//  iTunesFavoriteApp
//
//  Created by Juan Pablo on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import Foundation
import RxSwift

protocol RemoteArtistRepositoryProtocol {
    func getArtist(with query: SearchTerms) -> Single<[ArtistModel]>
}

class RemoteArtistRepository {
    private let api: ApiClient
    
    init(api: ApiClient) {
        self.api = api
    }
}
extension RemoteArtistRepository: RemoteArtistRepositoryProtocol {
    func getArtist(with query: SearchTerms) -> Single<[ArtistModel]> {
        return api.request(API.Media.searchTracks(by: query))
            .do(onSuccess: { print($0) })
            .map { $0.results }
    }
}
