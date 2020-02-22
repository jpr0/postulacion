//
//  FavoritesContract.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 22-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit

protocol FavoritesListViewProtocol: class {
    var presenter: FavoritesListPresenterProtocol? { get set }

    func display(favorites: [ArtistModel])

    func showLoading()
    func hideLoading()
}

protocol FavoritesListRouterProtocol: class {
    var viewController: UIViewController? { get set }

    func showTrackDetails(artistModel: ArtistModel)
    func show(error: Error)
}

protocol FavoritesListInteractorProtocol: class {
    var delegate: FavoritesListInteractorDelegate? { get set }

    func fetchAllFavorites()
}

protocol FavoritesListInteractorDelegate: class {
    func fetchAllFavoritesSuccess(favorites: [ArtistModel])
    func fetchAllFavoritesFail(error: Error)
}

protocol FavoritesListPresenterProtocol: class {
    var view: FavoritesListViewProtocol? { get set }
    var router: FavoritesListRouterProtocol? { get set }
    var interactor: FavoritesListInteractorProtocol? { get set }

    func load()
    func selected(track: ArtistModel)
}
