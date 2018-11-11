//
//  TransactionDetailCoordinator.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol TransactionDetailCoordinator: Coordinator {
    
}

class TransactionDetailCoordinatorImpl: TransactionDetailCoordinator {
    
    let navigationController: UINavigationController
    let container: Container
    let selectedTransaction: TransactionOverview
    
    // MARK: - Coordinator
    init(navigationController: UINavigationController, container: Container, selectedTransaction: TransactionOverview) {
        self.navigationController = navigationController
        self.container = container
        self.selectedTransaction = selectedTransaction
    }
    
    func start() {
        let viewController = container.resolve(TransactionDetailViewController.self, argument: selectedTransaction)!
        viewController.viewModel.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
    }
}
