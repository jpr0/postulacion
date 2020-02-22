//
//  TrackDetailsViewController.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class TrackDetailsViewController: UIViewController, HudDisplayable {

    var presenter: TrackDetailsPresenterProtocol?

    var hud: HudWrapper?
    
    private let bag = DisposeBag()
    private let isFavorite = BehaviorSubject<Bool>(value: false)
    private let artist = PublishSubject<ArtistModel>()
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var detailsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tracks Details"
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.reload()
    }
    
    private func setupUI() {
        isFavorite
            .asObservable()
            .observeOn(MainScheduler.instance)
            .map { $0 == true ? "favorite" : "favorite_no" }
            .map { UIImage(named: $0) }
            .bind(to: favoriteButton.rx.backgroundImage(for: .normal))
            .disposed(by: bag)

        artist
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.imageFromUrl(urlString: $0.artworkUrl100)
            })
            .disposed(by: bag)
        
        let artist = self.artist.asDriver(onErrorJustReturn: .empty())
        
        artist.map { $0.trackName }
            .drive(detailsLabel.rx.text)
            .disposed(by: bag)

        favoriteButton.rx.tap
            .withLatestFrom(isFavorite)
            .subscribe(onNext: { [weak self] isFavorite in
                switch isFavorite {
                case true:
                    self?.presenter?.deleteTrackFromFavorites()
                case false:
                    self?.presenter?.makeTrackFavorite()
                }
            })
            .disposed(by: bag)
            
        
        presenter?.load()
    }

    private func imageFromUrl(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        trackImageView.sd_setImage(with: url, completed: nil)
    }

}
extension TrackDetailsViewController: TrackDetailsViewProtocol {
    func display(artist: ArtistModel) {
        self.artist.onNext(artist)
    }

    func display(isFavorite: Bool) {
        self.isFavorite.onNext(isFavorite)
    }
}
