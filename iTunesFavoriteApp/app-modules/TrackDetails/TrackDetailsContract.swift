//
//  TrackDetailsProtocol.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit

protocol TrackDetailsViewProtocol: class {
    var presenter: TrackDetailsPresenterProtocol? { get set }

    func display(artist: ArtistModel)
    func display(isFavorite: Bool)

    func showLoading()
    func hideLoading()
}

protocol TrackDetailsInteractorProtocol: class {
    var delegate: TrackDetailsInteractorDelegate? { get set }

    func saveTrackAsFavorite(with: ArtistModel)
    func existsTrackAsFavorite(by id: Int32)
    func deleteTrackAsFavorite(by id: Int32)
}

protocol TrackDetailsInteractorDelegate: class {
    func makeTrackFavoriteSuccess()
    func makeTrackFavoriteFail(error: Error)
    
    func existsFavoriteSateSuccess(state: Bool)
    func existsFavoriteSateFail(error: Error)
    
    func deleteTrackFromFavoritesSuccesss()
    func deleteTrackFavoriteFail(error: Error)
}

protocol TrackDetailsRouterProtocol: class {
    var viewController: UIViewController? { get set }

    func show(error: Error)
}

protocol TrackDetailsPresenterProtocol: class {
    var view: TrackDetailsViewProtocol? { get set }
    var interactor: TrackDetailsInteractorProtocol? { get set }
    var router: TrackDetailsRouterProtocol? { get set }

    func load()
    func reload()
    
    func makeTrackFavorite()
    func deleteTrackFromFavorites()
}
