//
//  ApplicationController.swift
//  iTunesFavoriteApp
//
//  Created by slacker on 20-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit

protocol AppInitializable {
    func start(with window: UIWindow)
}

class ApplicationController {
    private let factory: ApplicationFactoryProtocol

    init(factory: ApplicationFactoryProtocol) {
        self.factory = factory
    }
}
extension ApplicationController: AppInitializable {
    func start(with window: UIWindow) {
        window.rootViewController = startHome()
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }

    func startHome() -> UIViewController {
        let view = UITabBarController()
        view.viewControllers = [startSearchModule(), startFavoriteModule()]

        return view
    }
    
    func startSearchModule() -> UIViewController {
        let view = ArtistViewController()
        let router = ArtistListRouter(factory: factory)
        let interactor = ArtistListInteractor(remoteArtistRepository: factory.artistRepository())
        let presenter = ArtistListPresenter(interactor: interactor, router: router)

        view.presenter = presenter
        presenter.view = view
        interactor.delegate = presenter
        router.viewController = view
        view.hud = SVProgressHUDWrapper()
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        router.navigationController = navigationController

        return navigationController
    }
    
    func startFavoriteModule() -> UIViewController {
        let view = FavoritesListViewController()
        let router = FavoritesListRouter(factory: factory)
        let interactor = FavoritesListInteractor(localFavoriteStoreRepository: factory.localRepository())
        let presenter = FavoritesListPresenter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.delegate = presenter
        router.viewController = view
        view.hud = SVProgressHUDWrapper()
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        router.navigationController = navigationController
        
        return navigationController
    }
}
