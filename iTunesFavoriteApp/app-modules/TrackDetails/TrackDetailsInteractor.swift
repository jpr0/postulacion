//
//  TrackDetailsInteractor.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 22-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import Foundation
import RxSwift

class TrackDetailsInteractor {
    var delegate: TrackDetailsInteractorDelegate?

    private let localFavoriteRepository: LocalFavoriteArtistRepositoryProtocol

    private let bag = DisposeBag()
    
    init(localFavoriteRepository: LocalFavoriteArtistRepositoryProtocol) {
        self.localFavoriteRepository = localFavoriteRepository
    }
}
extension TrackDetailsInteractor: TrackDetailsInteractorProtocol {
    func existsTrackAsFavorite(by id: Int32) {
        localFavoriteRepository.existsFavorite(by: id)
            .subscribe(onCompleted: {
                self.delegate?.existsFavoriteSateSuccess(state: true)
            }) { error in
                if let error = error as? LocalStoreError, error == LocalStoreError.empty {
                    self.delegate?.existsFavoriteSateSuccess(state: false)
                    return
                }
                
                self.delegate?.makeTrackFavoriteFail(error: error)
            }
            .disposed(by: bag)
    }
    
    func saveTrackAsFavorite(with artist: ArtistModel) {
        localFavoriteRepository.save(artist: artist)
            .subscribe(onCompleted: {
                self.delegate?.makeTrackFavoriteSuccess()
            }) { error in
                self.delegate?.makeTrackFavoriteFail(error: error)
            }
            .disposed(by: bag)
    }

    func deleteTrackAsFavorite(by id: Int32) {
        localFavoriteRepository.deleteArtist(by: id)
            .subscribe(onCompleted: {
                self.delegate?.deleteTrackFromFavoritesSuccesss()
            }) { error in
                self.delegate?.deleteTrackFavoriteFail(error: error)
            }
            .disposed(by: bag)
    }
}
