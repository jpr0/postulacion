//
//  ApplicationFactory.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import Foundation

protocol ApplicationFactoryProtocol {
    func artistRepository() -> RemoteArtistRepositoryProtocol
    func localRepository() -> LocalFavoriteArtistRepositoryProtocol
}

class ApplicationFactory {
    private let environment: Environment
    private let client: ApiClient

    private lazy var dataStack = CoreDataStack(modelName: "iTunesModel")
    
    init(environment: Environment) {
        self.environment = environment

        let noCacheConfig = URLSessionConfiguration.default
        noCacheConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        noCacheConfig.urlCache = nil
        
        let url = URL(string: environment.urlString)!

        client = RestClient(manager: URLSession(configuration: noCacheConfig), url: url)
    }
}
extension ApplicationFactory: ApplicationFactoryProtocol {
    func artistRepository() -> RemoteArtistRepositoryProtocol {
        return RemoteArtistRepository(api: client)
    }

    func localRepository() -> LocalFavoriteArtistRepositoryProtocol {
        let localStore = CoreDataLocalStore(stack: dataStack)

        return LocalFavoriteArtistRepository(localStore: localStore)
    }
}
