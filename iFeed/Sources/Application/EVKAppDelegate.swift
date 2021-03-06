//
//  EVKAppDelegate.swift
//  iFeed
//
//  Created by Evgeny Karkan on 8/14/15.
//  Copyright (c) 2015 Evgeny Karkan. All rights reserved.
//

import UIKit

@UIApplicationMain

class EVKAppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - UIApplicationDelegate APIs
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        EVKBrain.brain.startServices()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        EVKBrain.brain.presenter.openURL(url)
        return true
    }
}
