//
//  HomeViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-21.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

protocol RefreshDelegate {
    func refreshTableView()
}

class HomeViewController: SelectionTableViewController, RefreshDelegate {
    
    override func viewDidLoad() {
        CardManager.sharedInstance.setUp()
        super.viewDidLoad()
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red:0.29, green:0.13, blue:0.45, alpha:1.0).cgColor,UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor]
        
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DownloadViewController" {
            let dlvc = segue.destination as! DownloadViewController
            dlvc.delegate = self
        }
        if segue.identifier == "AddCardViewController" {
            let acvc = segue.destination as! AddCardViewController
            acvc.delegate = self
        }
    }
    
    func refreshTableView() {
        typeSegmentedControl.selectedSegmentIndex = 0
        cardManager.setUp()
        tableViewDataManager.updateData()
        selectionTableView.reloadData()
        refreshTableViewHeight()
    }
}
