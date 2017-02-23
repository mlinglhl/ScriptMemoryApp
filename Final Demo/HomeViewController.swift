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
    let tableViewDataManager = TableViewDataManager()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTableViewHeight()
        selectionTableView.delegate = self
        selectionTableView.dataSource = tableViewDataManager
        cardManager.setUp()
    }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        let type = typeSegmentedControl.titleForSegment(at: typeSegmentedControl.selectedSegmentIndex)
        tableViewDataManager.changeType(type!)
        selectionTableView.reloadData()
        refreshTableViewHeight()
    }
}
