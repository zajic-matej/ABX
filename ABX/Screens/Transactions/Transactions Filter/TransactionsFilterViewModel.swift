//
//  TransactionsFilterViewModel.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

protocol TransactionsFilterViewModel: class {
    var coordinator: TransactionsFilterCoordinator? { get set }
    var filtersObservale: Observable<[Filter]> { get }
    
    func select(filter: Filter)
    func close()
}

class TransactionsFilterViewModelImpl: TransactionsFilterViewModel {
    
    // Dependencies
    var model: TransactionsFilterModel
    var coordinator: TransactionsFilterCoordinator?
    
    // Properties
    lazy var filtersObservale: Observable<[Filter]> = {
        return Observable.just(model.filters)
    }()
    
    init(model: TransactionsFilterModel) {
        self.model = model
    }

    func select(filter: Filter) {
        coordinator?.selectedFilter?(filter)
        close()
    }
    
    func close() {
        coordinator?.finish()
    }
}
