//
//  UIViewController+Hud.swift
//  iTunesFavoriteApp
//
//  Created by Slacker on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol HudWrapper {
    func show()
    func hide()
}

protocol HudDisplayable {
    var hud: HudWrapper? { get set }
    
    func showLoading()
    func hideLoading()
}

extension HudDisplayable {
    func showLoading() {
        hud?.show()
    }
    
    func hideLoading() {
        hud?.hide()
    }
}

class SVProgressHUDWrapper: HudWrapper {
    init() {
        SVProgressHUD.setMaximumDismissTimeInterval(1.0)
    }
    
    func show() {
        DispatchQueue.main.async(execute: SVProgressHUD.show)
    }
    
    func hide() {
        DispatchQueue.main.async(execute: SVProgressHUD.dismiss)
    }
}

