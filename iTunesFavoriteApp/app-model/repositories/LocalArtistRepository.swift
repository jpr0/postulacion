//
//  LocalArtistRepository.swift
//  iTunesFavoriteApp
//
//  Created by Juan Pablo on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import RxSwift

protocol LocalFavoriteArtistRepositoryProtocol {
    func save(artist: ArtistModel) -> Completable
    func deleteArtist(by id: Int32) -> Completable
    func retrieveAll() -> Single<[ArtistModel]>
}

class LocalFavoriteArtistRepository: LocalFavoriteArtistRepositoryProtocol {
    private let localStore: LocalStoreProtocol
    
    init(localStore: LocalStoreProtocol) {
        self.localStore = localStore
    }
    
    func save(artist: ArtistModel) -> Completable {
        // TODO
        return Completable.empty()
    }
    
    func deleteArtist(by id: Int32) -> Completable {
        // TODO
        return Completable.empty()
    }
    
    func retrieveAll() -> Single<[ArtistModel]> {
        // TODO
        return Single.just([])
    }

}
