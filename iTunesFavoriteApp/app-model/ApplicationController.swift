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

    init(environment: Environment) {
        self.environment = environment
    }
}
extension ApplicationController: AppInitializable {
    func start(with window: UIWindow) {
        let rootViewController = UINavigationController()

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
