//
//  TransactionListCoordinator.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol TransactionListCoordinator: Coordinator {
    func showTransactionDetail(transaction: TransactionOverview)
    func showFilter(selectedFilterBlock: @escaping (Filter) -> Void)
}

class TransactionListCoordinatorImpl: TransactionListCoordinator {
  
    let navigationController: UINavigationController
    let container: Container
    
    // MARK: - Coordinator
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let viewController = container.resolve(TransactionListViewController.self)!
        viewController.viewModel.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func finish() {
        navigationController.viewControllers = []
    }
    
    func showTransactionDetail(transaction: TransactionOverview) {
        let coordinator = container.resolve(TransactionDetailCoordinator.self, arguments: navigationController, container, transaction)!
        coordinator.start()
    }
    
    func showFilter(selectedFilterBlock: @escaping (Filter) -> Void) {
        let coordinator = container.resolve(TransactionsFilterCoordinator.self, arguments: navigationController, container)!
        coordinator.selectedFilter = { selectedFilter in
            selectedFilterBlock(selectedFilter)
        }
        coordinator.start()
    }
}
