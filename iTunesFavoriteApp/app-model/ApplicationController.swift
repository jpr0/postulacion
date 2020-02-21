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
    private let environment: Environment

    private let rootViewController = UINavigationController()
    
    init(environment: Environment) {
        self.environment = environment
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
        let noCacheConfig = URLSessionConfiguration.default
        noCacheConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        noCacheConfig.urlCache = nil
        
        let url = URL(string: environment.urlString)!
        let client = RestClient(manager: URLSession(configuration: noCacheConfig), url: url)

        let remoteRepository = RemoteArtistRepository(api: client)
        
        let view = ArtistViewController()
        let router = ArtistListRouter()
        let interactor = ArtistListInteractor(remoteArtistRepository: remoteRepository)
        let presenter = ArtistListPresenter(interactor: interactor, router: router)

        view.presenter = presenter
        presenter.view = view
        router.viewController = view
        interactor.delegate = presenter
        
        return view
    }
}
