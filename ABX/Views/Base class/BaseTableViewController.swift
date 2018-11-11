//
//  BaseTableVC.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class BaseTableViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero)

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.sv([tableView])
        
        tableView.Top == view.Top
        tableView.Bottom == view.Bottom
        tableView.Left == view.Left
        tableView.Right == view.Right
        
        // Remove extra separator lines in a UITableView
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor.clear
    }
}
