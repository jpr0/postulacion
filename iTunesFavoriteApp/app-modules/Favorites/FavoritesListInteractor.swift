//
//  FavoritesListInteractor.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 22-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import Foundation
import RxSwift

class FavoritesListInteractor {
    var delegate: FavoritesListInteractorDelegate?

    private let bag = DisposeBag()
    
    private var localFavoriteStoreRepository: LocalFavoriteArtistRepositoryProtocol
    
    init(localFavoriteStoreRepository: LocalFavoriteArtistRepositoryProtocol) {
        self.localFavoriteStoreRepository = localFavoriteStoreRepository
    }
}
extension FavoritesListInteractor: FavoritesListInteractorProtocol {
    func fetchAllFavorites() {
        localFavoriteStoreRepository.retrieveAll()
            .subscribe(onSuccess: { artists in
                self.delegate?.fetchAllFavoritesSuccess(favorites: artists)
            }) { error in
                self.delegate?.fetchAllFavoritesFail(error: error)
            }
            .disposed(by: bag)
    }
}
