//
//  LocalStore.swift
//  iTunesFavoriteApp
//
//  Created by Juan Pablo on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import CoreData
import RxSwift

enum LocalStoreError: Error {
    case empty
}

protocol LocalStoreProtocol {
    func save(artist: ArtistModel) -> Completable
    func retrieveAll() -> Single<[TrackEntity]>
    func deleteArtist(by id: Int32) -> Completable
}

class CoreDataLocalStore {
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }

}
extension CoreDataLocalStore: LocalStoreProtocol {
    
    func save(artist: ArtistModel) -> Completable {
        return Completable.create { observer in
            self.stack.storeContainer.performBackgroundTask { context in

                let store = TrackEntity(context: context)
                store.wrapperType = artist.wrapperType
                store.collectionId = artist.collectionId
                store.artistName = artist.artistName
                store.collectionName = artist.collectionName
                store.trackName = artist.trackName
                store.previewUrl = artist.previewUrl
                store.artworkUrl100 = artist.artworkUrl100

                do {
                    try context.save()
                    observer(.completed)
                } catch {
                    observer(.error(error))
                }
            }

            return Disposables.create()
        }
    }

    func retrieveAll() -> Single<[TrackEntity]> {
        let privateManagedObjectContext = stack.storeContainer.newBackgroundContext()

        return Single.create { single in
            let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: TrackEntity.fetchAll()) { asynchronousFetchResult in
                guard let result = asynchronousFetchResult.finalResult else {
                    single(.error(LocalStoreError.empty))
                    return
                }
                single(.success(result))
            }
            do {
                try privateManagedObjectContext.execute(asynchronousFetchRequest)
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func deleteArtist(by id: Int32) -> Completable {
        return Completable.create { observer in
            // TODO
            return Disposables.create()
        }
    }

}
