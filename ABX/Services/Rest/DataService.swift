//
//  DataProvider.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxMoya
import Unbox

protocol DataService {
    func listAllTransactions() -> Observable<[TransactionOverview]>
    func getTransactionDetailFor(transactionOverview: TransactionOverview) -> Observable<Transaction>
}

class DataServiceImpl: DataService {
    
    private let restProvider: MoyaProvider<RestAPI>
    
    init(restProvider: MoyaProvider<RestAPI>) {
        self.restProvider = restProvider
    }
    
    func listAllTransactions() -> Observable<[TransactionOverview]> {
        return restProvider.rx.request(.listAllTransactions)
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map { resp  in
                return try unbox(data: resp.data, atKeyPath: "items")
            }
    }
    
    func getTransactionDetailFor(transactionOverview: TransactionOverview) -> Observable<Transaction> {
        return restProvider.rx.request(.getTransaction(transactionId: transactionOverview.id))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map { resp in
                return try unbox(data: resp.data)
            }
    }
}
