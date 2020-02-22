//
//  FavoritesListRouter.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 22-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit

class FavoritesListRouter {
    var viewController: UIViewController?
    var navigationController: UINavigationController?
    
    private let factory: ApplicationFactoryProtocol
    
    init(factory: ApplicationFactoryProtocol) {
        self.factory = factory
    }
}
extension FavoritesListRouter: FavoritesListRouterProtocol {
    func showTrackDetails(artistModel: ArtistModel) {
        let view = TrackDetailsViewController()
        let router = TrackDetailsRouter()
        let interctor = TrackDetailsInteractor(localFavoriteRepository: factory.localRepository())
        let presenter = TrackDetailsPresenter(artistModel: artistModel)

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interctor
        interctor.delegate = presenter
        router.viewController = view
        router.navigationController = navigationController
        
        view.hud = SVProgressHUDWrapper()
        
        navigationController?.pushViewController(view, animated: true)
    }

    func show(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(okAction)

        DispatchQueue.main.async { [weak self] in
            self?.viewController?.present(alert, animated: true, completion: nil)
        }
    }
}
