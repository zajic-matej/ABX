//
//  AppDelegate.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        // Register dependency injections
        let appAssembly = AppAssembly()
        appAssembly.assemble()
        
        // Start main coordinator
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window, appAssembly: appAssembly)
        appCoordinator?.start()
        
        setupGlobalUI()
        return true
    }
    
    func setupGlobalUI() {
        window?.tintColor = UIColor.primaryText
    }
}

