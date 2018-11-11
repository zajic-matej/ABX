//
//  TransactionListModel.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import RxSwift

protocol TransactionListModel {
    func setDelegate(delegate: TransactionListModelDelegate)
    func loadTransactions()
    func filterTransactions(filter: Filter)
}

protocol TransactionListModelDelegate: class {
    func transactionsLoaded(transactions: [TransactionOverview])
    func receiveError(error: Error)
}

class TransactionListModelImpl: TransactionListModel {
 
    // Dependencies
    private let dataProvider: DataService
    
    // Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private weak var delegate: TransactionListModelDelegate?
    private var transactions: [TransactionOverview] = []
    
    init(dataProvider: DataService) {
        self.dataProvider = dataProvider
    }
    
    func setDelegate(delegate: TransactionListModelDelegate) {
        self.delegate = delegate
    }
    
    func loadTransactions() {
        dataProvider.listAllTransactions().subscribe(onNext: { [weak self] transactions in
            self?.transactions = transactions
            self?.delegate?.transactionsLoaded(transactions: transactions)
        }, onError: { [weak self] error in
            self?.delegate?.receiveError(error: error)
        }).disposed(by: disposeBag)
    }
    
    func filterTransactions(filter: Filter) {
        if let direction = filter.direction {
            let filteredTransactions = transactions.filter { $0.direction == direction }
            delegate?.transactionsLoaded(transactions: filteredTransactions)
        } else {
            delegate?.transactionsLoaded(transactions: transactions)
        }
    }
}
