//
//  ArtistsListPresentter.swift
//  iTunesFavoriteApp
//
//  Created by Juan Pablo on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import Foundation

class ArtistListPresenter {
    weak var view: ArtistListViewProtocol?

    var interactor: ArtistListInteractorProtocol?
    var router: ArtistListRouterProtocol?

    init(interactor: ArtistListInteractorProtocol, router: ArtistListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
extension ArtistListPresenter: ArtistListPresenterProtocol {
    func searchArtists(by name: String) {
        view?.showLoading()
        interactor?.fetchArtists(by: name)
    }
}
extension ArtistListPresenter: ArtistListInteractorDelegate {
    func fetchArtistSuccess(artists: [ArtistModel]) {
        view?.hideLoading()
        view?.display(artists: artists)
    }
    
    func fetchArtistFail(error: Error) {
        view?.hideLoading()
        router?.show(error: error)
    }
}
