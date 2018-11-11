//
//  TransactionsAssembly.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import Swinject
import UIKit

class TransactionsAssembly {
    
    func assemble(container: Container) {
        registerTransactionList(container: container)
        registerTransactionDetail(container: container)
        registerTransactionFilter(container: container)
    }
    
    private func registerTransactionList(container: Container) {
        container.register(TransactionListViewController.self) { r in
            TransactionListViewController(
                viewModel: r.resolve(TransactionListViewModel.self)!
            )
        }
        
        container.register(TransactionListViewModel.self) { r in
            TransactionListViewModelImpl(
                model: r.resolve(TransactionListModel.self)!
            )
        }
        
        container.register(TransactionListModel.self) { r in
            TransactionListModelImpl(
                dataProvider: r.resolve(DataService.self)!
            )
        }
        
        container.register(TransactionListCoordinator.self) { r, navigationController, container in
            TransactionListCoordinatorImpl(
                navigationController: navigationController,
                container: container
            )
        }
    }
    
    private func registerTransactionDetail(container: Container) {
        container.register(TransactionDetailViewController.self) { r, transactionOverview in
            TransactionDetailViewController(
                viewModel: r.resolve(TransactionDetailViewModel.self, argument: transactionOverview as TransactionOverview)!
            )
        }
        
        container.register(TransactionDetailViewModel.self) { r, transactionOverview in
            TransactionDetailViewModelImpl(
                model: r.resolve(TransactionDetailModel.self, argument: transactionOverview as TransactionOverview)!
            )
        }
        
        container.register(TransactionDetailModel.self) { r, transactionOverview in
            TransactionDetailModelImpl(
                transactionOverview: transactionOverview,
                dataProvider: r.resolve(DataService.self)!
            )
        }
        
        container.register(TransactionDetailCoordinator.self) { r, navigationController, container, selectedTransaction in
            TransactionDetailCoordinatorImpl(
                navigationController: navigationController,
                container: container,
                selectedTransaction: selectedTransaction
            )
        }
    }
    
    private func registerTransactionFilter(container: Container) {
        container.register(TransactionsFilterViewController.self) { r in
            TransactionsFilterViewController(
                viewModel: r.resolve(TransactionsFilterViewModel.self)!
            )
        }
        
        container.register(TransactionsFilterViewModel.self) { r in
            TransactionsFilterViewModelImpl(
                model: r.resolve(TransactionsFilterModel.self)!
            )
        }
        
        container.register(TransactionsFilterModel.self) { r in
            TransactionsFilterModelImpl()
        }
        
        container.register(TransactionsFilterCoordinator.self) { r, navigationController, container in
            TransactionsFilterCoordinatorImpl(
                navigationController: navigationController,
                container: container
            )
        }
    }
}


