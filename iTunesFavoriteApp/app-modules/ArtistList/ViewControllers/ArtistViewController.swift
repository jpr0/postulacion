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

class ArtistViewController: UIViewController, HudDisplayable {

    var presenter: ArtistListPresenterProtocol?

    var hud: HudWrapper?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private let items = BehaviorSubject<[ArtistModel]>(value: [])
    private let favorites = BehaviorSubject<[ArtistModel]>(value: [])
    
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search Tracks"
        
        setupUI()
    }

    private func setupUI() {
        _ = searchBar.rx.text.orEmpty.changed
            .filter { !$0.isEmpty }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                self?.presenter?.searchArtists(by: text)
            })

        items
            .asObservable()
            .bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, element: ArtistModel) in
                let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

                cell.textLabel?.text = element.trackName

                return cell
            }
            .disposed(by: bag)
        
        tableView.rx.itemSelected
            .map { try self.items.value()[$0.row] }
            .subscribe(onNext: { item in
                self.presenter?.selected(track: item)
            })
            .disposed(by: bag)
    }
    
    
}
extension ArtistViewController: ArtistListViewProtocol {
    func display(artists: [ArtistModel]) {
        items.onNext(artists)
    }
}
