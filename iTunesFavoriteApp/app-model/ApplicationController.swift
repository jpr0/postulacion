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
    private let rootViewController = UINavigationController()

    private let factory: ApplicationFactoryProtocol

    init(factory: ApplicationFactoryProtocol) {
        self.factory = factory
    }
}
extension ApplicationController: AppInitializable {
    func start(with window: UIWindow) {
        rootViewController.pushViewController(startSearchModule(), animated: true)

        window.rootViewController = rootViewController
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }

    func startSearchModule() -> UIViewController {
        let view = ArtistViewController()
        let router = ArtistListRouter()
        let interactor = ArtistListInteractor(remoteArtistRepository: factory.artistRepository())
        let presenter = ArtistListPresenter(interactor: interactor, router: router)

        view.presenter = presenter
        presenter.view = view
        router.viewController = view
        interactor.delegate = presenter
        
        view.hud = SVProgressHUDWrapper()
        
        return view
    }
}
