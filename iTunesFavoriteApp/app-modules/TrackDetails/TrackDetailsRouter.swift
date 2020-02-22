//
//  TrackDetailsRouter.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit

class TrackDetailsRouter {
    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?
}
extension TrackDetailsRouter: TrackDetailsRouterProtocol {
    func show(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(okAction)

        DispatchQueue.main.async { [weak self] in
            self?.viewController?.present(alert, animated: true, completion: nil)
        }
    }
}

