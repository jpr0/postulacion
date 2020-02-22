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
    func existsFavorite(by id: Int32) -> Completable
}

class LocalFavoriteArtistRepository: LocalFavoriteArtistRepositoryProtocol {
    private let localStore: LocalStoreProtocol
    
    private let bag = DisposeBag()
    
    init(localStore: LocalStoreProtocol) {
        self.localStore = localStore
    }

    private func artist(from entity: TrackEntity) -> ArtistModel {
        ArtistModel(wrapperType: entity.wrapperType,
                    collectionId: entity.collectionId,
                    trackId: Int(entity.trackId),
                    artistName: entity.artistName,
                    collectionName: entity.collectionName,
                    trackName: entity.trackName,
                    previewUrl: entity.previewUrl,
                    artworkUrl100: entity.artworkUrl100)
    }
    
    func save(artist: ArtistModel) -> Completable {
        return localStore.save(artist: artist)
    }
    
    func deleteArtist(by id: Int32) -> Completable {
        return localStore.deleteArtist(by: id)
    }

    func existsFavorite(by id: Int32) -> Completable {
        return localStore.fetchArtist(by: id)
            .flatMapCompletable { _ in
                .empty()
            }
            .catchError { error in
                .error(error)
            }
    }

    func retrieveAll() -> Single<[ArtistModel]> {
        return localStore.retrieveAll().map { $0.map { self.artist(from: $0) } }
    }

}
