//
//  TransactionsFilterViewController.swift
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

class TransactionsFilterViewController: BaseTableViewController {
    
    // Dependencies
    let viewModel: TransactionsFilterViewModel
    
    // Properties
    let disposeBag: DisposeBag = DisposeBag()
    
    // Table view
    let sections: Variable<[TransactionFilterSection]> = Variable([])
    let dataSource = RxTableViewSectionedReloadDataSource<TransactionFilterSection>(
        configureCell: { dataSource, tableView, indexPath, filter in
            guard let cell = tableView.dequeueCell(cell: TransactionFilterCell.self, indexPath: indexPath) else {
                fatalError("Cell: cannot be created")
            }
            cell.configureWith(filter: filter)
            return cell
    })
    
    // Buttons
    let closeButton: UIBarButtonItem = UIBarButtonItem(title: LOC("button.close"), style: .plain, target: nil, action: nil)
    
    init(viewModel: TransactionsFilterViewModel) {
        self.viewModel = viewModel
        super.init()
        
        // Register all used cells
        tableView.registerCell(TransactionFilterCell.self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupRx() {
        super.setupRx()
        
        // Bind sections to tableview
        sections.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // Bind all available filters
        viewModel.filtersObservale
            .map { [TransactionFilterSection(items: $0)] }
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        // Observe selected items
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.itemSelected(indexPath: indexPath)
            }).disposed(by: disposeBag)
        
        // Observe close button
        closeButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel.close()
        }).disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        
        navigationItem.setLeftBarButton(closeButton, animated: false)
    }

    func itemSelected(indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedFilter = dataSource.sectionModels[indexPath.section].items[indexPath.row]
        viewModel.select(filter: selectedFilter)
    }
}

struct TransactionFilterSection {
    var items: [Item]
}
extension TransactionFilterSection: SectionModelType {
    typealias Item = Filter
    
    init(original: TransactionFilterSection, items: [Item]) {
        self = original
        self.items = items
    }
}
