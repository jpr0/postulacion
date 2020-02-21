//
//  ArtistListContract.swift
//  iTunesFavoriteApp
//
//  Created by Juan Pablo on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit

protocol ArtistListViewProtocol: class {
    var presenter: ArtistListPresenterProtocol? { get set }

    func display(artists: [ArtistModel])

    func showLoading()
    func hideLoading()
}

protocol ArtistListInteractorProtocol: class {
    var delegate: ArtistListInteractorDelegate? { get set }

    func fetchArtists(by name: String)
}

protocol ArtistListInteractorDelegate: class {
    func fetchArtistSuccess(artists: [ArtistModel])
    func fetchArtistFail(error: Error)
}

protocol ArtistListRouterProtocol: class {
    var viewController: UIViewController? { get set }

    func show(error: Error)
}

protocol ArtistListPresenterProtocol: class {
    var view: ArtistListViewProtocol? { get set }
    var interactor: ArtistListInteractorProtocol? { get set }
    var router: ArtistListRouterProtocol? { get set }

    func searchArtists(by name: String)
}
