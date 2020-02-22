//
//  TrackDetailsPresenter.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import Foundation

class TrackDetailsPresenter {
    weak var view: TrackDetailsViewProtocol?
    var router: TrackDetailsRouterProtocol?
    var interactor: TrackDetailsInteractorProtocol?

    private let artistModel: ArtistModel

    init(artistModel: ArtistModel) {
        self.artistModel = artistModel
    }
}
extension TrackDetailsPresenter: TrackDetailsPresenterProtocol {
    func load() {
        view?.display(artist: artistModel)
        view?.display(isFavorite: false)

        reload()
    }

    func reload() {
        interactor?.existsTrackAsFavorite(by: Int32(artistModel.trackId))
    }

    func makeTrackFavorite() {
        view?.showLoading()
        interactor?.saveTrackAsFavorite(with: artistModel)
    }

    func deleteTrackFromFavorites() {
        view?.showLoading()
        interactor?.deleteTrackAsFavorite(by: Int32(artistModel.trackId))
    }
}
extension TrackDetailsPresenter: TrackDetailsInteractorDelegate {
    func existsFavoriteSateSuccess(state: Bool) {
        view?.hideLoading()
        view?.display(isFavorite: state)
    }
    
    func existsFavoriteSateFail(error: Error) {
        view?.hideLoading()
        router?.show(error: error)
    }
    
    func makeTrackFavoriteSuccess() {
        view?.hideLoading()
        view?.display(isFavorite: true)
    }
    
    func makeTrackFavoriteFail(error: Error) {
        view?.hideLoading()
        router?.show(error: error)
    }
    
    func deleteTrackFromFavoritesSuccesss() {
        view?.hideLoading()
        view?.display(isFavorite: false)
    }
    
    func deleteTrackFavoriteFail(error: Error) {
        view?.hideLoading()
        router?.show(error: error)
    }
}
