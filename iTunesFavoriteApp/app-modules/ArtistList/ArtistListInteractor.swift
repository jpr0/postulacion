//
//  ArtistListInteractor.swift
//  iTunesFavoriteApp
//
//  Created by Juan Pablo on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import RxSwift

class ArtistListInteractor {
    weak var delegate: ArtistListInteractorDelegate?

    private let bag = DisposeBag()

    private let remoteArtistRepository: RemoteArtistRepositoryProtocol
    
    init(remoteArtistRepository: RemoteArtistRepositoryProtocol) {
        self.remoteArtistRepository = remoteArtistRepository
    }
}
extension ArtistListInteractor: ArtistListInteractorProtocol {
    func fetchArtists(by name: String) {
        remoteArtistRepository.getArtist(with: SearchTerms(terms: name))
            .subscribe(onSuccess: { artists in
                self.delegate?.fetchArtistSuccess(artists: artists)
            }) { error in
                self.delegate?.fetchArtistFail(error: error)
            }
            .disposed(by: bag)
    }
}
