//
//  HomeViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-21.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var selectionTableView: UITableView!
    @IBOutlet weak var selectionTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!

    let cardManager = CardManager.sharedInstance
    var tableViewDataManager: TableViewDataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardManager.sharedInstance.setUp()
        selectionTableView.delegate = self
        tableViewDataManager = TableViewDataManager()
        refreshTableViewHeight()
        selectionTableView.dataSource = tableViewDataManager
    }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        let type = typeSegmentedControl.titleForSegment(at: typeSegmentedControl.selectedSegmentIndex)
        tableViewDataManager.changeType(type!)
        selectionTableView.reloadData()
        refreshTableViewHeight()
    }
}
