//
//  SearchArtisViewController.swift
//  iTunesFavoriteApp
//
//  Created by Juan Pablo on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArtistViewController: UIViewController {

    var presenter: ArtistListPresenterProtocol?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI() {
        let search = searchBar.rx.text.orEmpty.changed
            .filter { !$0.isEmpty }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                self?.presenter?.searchArtists(by: text)
            })
    }
}
extension ArtistViewController: ArtistListViewProtocol {
    func display(artists: [ArtistModel]) {
        print(artists)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
