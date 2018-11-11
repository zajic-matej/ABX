//
//  TransactionDetailViewController.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Stevia

class TransactionDetailViewController: BaseViewController {
    
    // Dependencies
    let viewModel: TransactionDetailViewModel
    
    // Properties
    let disposeBag: DisposeBag = DisposeBag()
    
    // SubViews
    lazy var detailView: TransactionDetailView = TransactionDetailView()
    
    init(viewModel: TransactionDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadTransactionDetail()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupRx() {
        super.setupRx()
        
        // Handle errors
        viewModel.errorObservable.subscribe(onNext: { [weak self] error in
            self?.showError(error: error)
        }).disposed(by: disposeBag)
        
        // Observe transaction detail
        viewModel.transactionOverviewObservable.subscribe(onNext: { [weak self] transactionOverview in
            self?.configureView(transactionOverview: transactionOverview)
        }).disposed(by: disposeBag)
        
        viewModel.transactionDetailObservable.subscribe(onNext: { [weak self] transactionDetail in
            self?.configureView(transactionDetail: transactionDetail)
        }).disposed(by: disposeBag)
    }
    
    func configureView(transactionOverview: TransactionOverview) {
        detailView.configureWith(transactionOverview: transactionOverview)
    }
    
    func configureView(transactionDetail: Transaction?) {
        detailView.configureWith(detail: transactionDetail)
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: LOC("network.default.error.title"), message: LOC("network.default.error.text"), preferredStyle: .alert)
        let action = UIAlertAction(title: LOC("ok"), style: .cancel) { [weak self] _ in
            self?.viewModel.goBack()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.sv([detailView])
        
        view.Top == detailView.Top
        view.Left == detailView.Left
        view.Right == detailView.Right
    }
}
