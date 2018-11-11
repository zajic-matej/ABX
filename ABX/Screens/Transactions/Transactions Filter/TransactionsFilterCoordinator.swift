//
//  TransactionsFilterCoordinator.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol TransactionsFilterCoordinator: Coordinator {
    var selectedFilter: ((Filter) -> Void)? { get set }
}

class TransactionsFilterCoordinatorImpl: TransactionsFilterCoordinator {
    
    let navigationController: UINavigationController
    let container: Container
    
    var selectedFilter: ((Filter) -> Void)?
    
    // MARK: - Coordinator
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let viewController = container.resolve(TransactionsFilterViewController.self)!
        viewController.viewModel.coordinator = self
        
        let filterNavigationController = UINavigationController(rootViewController: viewController)
        navigationController.present(filterNavigationController, animated: true, completion: nil)
    }
    
    func finish() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func select(filter: Filter) {
        selectedFilter?(filter)
        finish()
    }
}
