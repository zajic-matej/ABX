//
//  TransactionListVM.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TransactionListViewModel: class {
    var coordinator: TransactionListCoordinator? { get set }
    var errorObservable: Observable<Error> { get }
    var transactionsListObservable: Observable<[TransactionOverview]> { get }
    
    func loadTransactions()
    func showDetailFor(transaction: TransactionOverview)
    func showFilter()
}

class TransactionListViewModelImpl: TransactionListViewModel {
    
    // Dependencies
    var model: TransactionListModel
    var coordinator: TransactionListCoordinator?
    
    // Properties
    lazy var errorObservable: Observable<Error> = {
        return errorPublishSubject.asObservable()
    }()
    
    lazy var transactionsListObservable: Observable<[TransactionOverview]> = {
        return transactionPublishSubject.asObservable()
    }()
    
    lazy var errorPublishSubject: PublishSubject<Error> = PublishSubject()
    lazy var transactionPublishSubject: PublishSubject<[TransactionOverview]> = PublishSubject()
    
    init(model: TransactionListModel) {
        self.model = model
        self.model.setDelegate(delegate: self)
    }

    func loadTransactions() {
        model.loadTransactions()
    }
    
    func showDetailFor(transaction: TransactionOverview) {
        coordinator?.showTransactionDetail(transaction: transaction)
    }
    
    func showFilter() {
        coordinator?.showFilter(selectedFilterBlock: { [weak self] filter in
            self?.model.filterTransactions(filter: filter)
        })
    }
}

extension TransactionListViewModelImpl: TransactionListModelDelegate {
    func transactionsLoaded(transactions: [TransactionOverview]) {
        transactionPublishSubject.onNext(transactions)
    }
    
    func receiveError(error: Error) {
        errorPublishSubject.onNext(error)
    }
}
