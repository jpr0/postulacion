//
//  FavoritesListPresenter.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 22-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import Foundation

class FavoritesListPresenter {
    weak var view: FavoritesListViewProtocol?
    var router: FavoritesListRouterProtocol?
    var interactor: FavoritesListInteractorProtocol?
}
extension FavoritesListPresenter: FavoritesListPresenterProtocol {
    func load() {
        view?.showLoading()

        interactor?.fetchAllFavorites()
    }
    
    func selected(track: ArtistModel) {
        router?.showTrackDetails(artistModel: track)
    }
}
extension FavoritesListPresenter: FavoritesListInteractorDelegate {
    func fetchAllFavoritesSuccess(favorites: [ArtistModel]) {
        view?.hideLoading()
        view?.display(favorites: favorites)
    }
    
    func fetchAllFavoritesFail(error: Error) {
        view?.hideLoading()
        router?.show(error: error)
    }
}
