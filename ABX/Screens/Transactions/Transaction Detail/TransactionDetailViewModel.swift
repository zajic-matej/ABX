//
//  TransactionDetailViewModel.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TransactionDetailViewModel: class {
    var coordinator: TransactionDetailCoordinator? { get set }
    var errorObservable: Observable<Error> { get }
    var transactionDetailObservable: Observable<Transaction?> { get }
    var transactionOverviewObservable: Observable<TransactionOverview> { get }
    
    func loadTransactionDetail()
    func goBack()
}

class TransactionDetailViewModelImpl: TransactionDetailViewModel {
    
    // Dependencies
    var model: TransactionDetailModel
    var coordinator: TransactionDetailCoordinator?
    
    // Properties
    lazy var errorObservable: Observable<Error> = {
        return errorPublishSubject.asObservable()
    }()
    
    lazy var transactionDetailObservable: Observable<Transaction?> = {
        return transactionPublishSubject.asObservable()
    }()
    
    var transactionOverviewObservable: Observable<TransactionOverview> {
        return Observable.just(model.transactionOverview)
    }
    
    lazy var errorPublishSubject: PublishSubject<Error> = PublishSubject()
    lazy var transactionPublishSubject: PublishSubject<Transaction?> = PublishSubject()
    
    init(model: TransactionDetailModel) {
        self.model = model
        self.model.setDelegate(delegate: self)
    }
    
    func loadTransactionDetail() {
        model.loadTransactionDetail()
    }
    
    func goBack() {
        coordinator?.finish()
    }
}

extension TransactionDetailViewModelImpl: TransactionDetailModelDelegate {
    func transactionLoaded(transactionDetail: Transaction) {
        transactionPublishSubject.onNext(transactionDetail)
    }
    
    func receiveError(error: Error) {
        errorPublishSubject.onNext(error)
    }
}
