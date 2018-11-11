//
//  TransactionListVC.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TransactionListViewController: BaseTableViewController {
    
    // Dependencies
    let viewModel: TransactionListViewModel
    
    // Properties
    let disposeBag: DisposeBag = DisposeBag()
    
    // Table view
    let sections: Variable<[TransactionListSection]> = Variable([])
    let dataSource = RxTableViewSectionedReloadDataSource<TransactionListSection>(
        configureCell: { dataSource, tableView, indexPath, transaction in
            
            guard let cell = tableView.dequeueCell(cell: TransactionOverviewCell.self, indexPath: indexPath) else {
                fatalError("Cell: cannot be created")
            }
            cell.configureWith(transaction: transaction)
            return cell
    })
    
    // Buttons
    let filterButton: UIBarButtonItem = UIBarButtonItem(title: LOC("button.filter"), style: .plain, target: nil, action: nil)
    
    init(viewModel: TransactionListViewModel) {
        self.viewModel = viewModel
        super.init()
        
        tableView.registerCell(TransactionOverviewCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadTransactions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupRx() {
        super.setupRx()
        
        sections.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.errorObservable.subscribe(onNext: { [weak self] error in
            self?.showError(error: error)
        }).disposed(by: disposeBag)
        
        viewModel.transactionsListObservable
            .map { [TransactionListSection(items: $0)] }
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.itemSelected(indexPath: indexPath)
        }).disposed(by: disposeBag)
        
        filterButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel.showFilter()
        }).disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        navigationItem.setRightBarButton(filterButton, animated: false)
    }

    func itemSelected(indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedTransaction = dataSource.sectionModels[indexPath.section].items[indexPath.row]
        showDetail(transaction: selectedTransaction)
    }
    
    func showDetail(transaction: TransactionOverview) {
        viewModel.showDetailFor(transaction: transaction)
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: LOC("network.default.error.title"), message: LOC("network.default.error.text"), preferredStyle: .alert)
        let action = UIAlertAction(title: LOC("ok"), style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

struct TransactionListSection {
    var items: [Item]
}
extension TransactionListSection: SectionModelType {
    typealias Item = TransactionOverview
    
    init(original: TransactionListSection, items: [Item]) {
        self = original
        self.items = items
    }
}
