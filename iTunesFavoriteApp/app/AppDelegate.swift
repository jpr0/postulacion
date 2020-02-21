//
//  AppDelegate.swift
//  iTunesFavoriteApp
//
//  Created by slacker on 20-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    private let environment = Environment(urlString: "")
    
    private var initializer: AppInitializable {
        ApplicationController(environment: environment)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = self.window else { return false }

        initializer.start(with: window)

        return true
    }
}

