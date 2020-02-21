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

    private let environment = Environment(urlString: "https://itunes.apple.com")
    
    private var initializer: AppInitializable {
        ApplicationController(environment: environment)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }

        initializer.start(with: window)

        return true
    }
}

