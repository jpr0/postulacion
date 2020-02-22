//
//  FavoritesViewController.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 22-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesListViewController: UIViewController, HudDisplayable {

    var presenter: FavoritesListPresenterProtocol?

    var hud: HudWrapper?
    
    @IBOutlet weak var tableView: UITableView!

    private let bag = DisposeBag()
    private let items = BehaviorSubject<[ArtistModel]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.load()
    }
    
    func setupUI() {
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
extension FavoritesListViewController: FavoritesListViewProtocol {
    func display(favorites: [ArtistModel]) {
        items.onNext(favorites)
    }
}
