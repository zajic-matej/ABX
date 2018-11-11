//
//  AppCoordinator.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let appAssembly: AppAssembly
    
    lazy var rootViewController: UITabBarController = {
        return UITabBarController()
    }()
    
    // MARK: - Coordinator
    init?(window: UIWindow?, appAssembly: AppAssembly) {
        guard let window = window else {
            return nil
        }
        self.window = window
        self.appAssembly = appAssembly
    }
    
    func start() {
        
        // Create UINavigationControllers and Coordinator for every tab
        let transactionsNavigationController = UINavigationController()
        let transactionsCoordinator = appAssembly.container.resolve(TransactionListCoordinator.self, arguments: transactionsNavigationController, appAssembly.container)
        
        // Configure UITabbarController
        rootViewController.setViewControllers([
            transactionsNavigationController
        ], animated: false)
        
        // Show UITabbarController in window
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        // Start child coordinators.
        // After start() transactionsListViewModel will have reference to his coordinator
        transactionsCoordinator?.start()
    }
    
    func finish() {
        fatalError("AppCoordinator cannot be finished")
    }
}

