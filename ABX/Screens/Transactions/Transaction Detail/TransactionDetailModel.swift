//
//  TransactionDetailModel.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import RxSwift

protocol TransactionDetailModel {
    var transactionOverview: TransactionOverview { get }
    
    func setDelegate(delegate: TransactionDetailModelDelegate)
    func loadTransactionDetail()
}

protocol TransactionDetailModelDelegate: class {
    func transactionLoaded(transactionDetail: Transaction)
    func receiveError(error: Error)
}

class TransactionDetailModelImpl: TransactionDetailModel {
    
    // Dependencies
    private let dataProvider: DataService
    
    // Properties
    let transactionOverview: TransactionOverview
    private let disposeBag: DisposeBag = DisposeBag()
    private weak var delegate: TransactionDetailModelDelegate?
    
    init(transactionOverview: TransactionOverview, dataProvider: DataService) {
        self.dataProvider = dataProvider
        self.transactionOverview = transactionOverview
    }
    
    func setDelegate(delegate: TransactionDetailModelDelegate) {
        self.delegate = delegate
    }
    
    func loadTransactionDetail() {
        dataProvider.getTransactionDetailFor(transactionOverview: transactionOverview).subscribe(onNext: { [weak self] transactionDetail in
            self?.delegate?.transactionLoaded(transactionDetail: transactionDetail)
        }, onError: { [weak self] error in
            self?.delegate?.receiveError(error: error)
        }).disposed(by: disposeBag)
    }
}
