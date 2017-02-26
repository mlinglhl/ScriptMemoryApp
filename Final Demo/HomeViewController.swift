//
//  HomeViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-21.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class HomeViewController: SelectionTableViewController {
        
    override func viewDidLoad() {
        CardManager.sharedInstance.setUp()
        super.viewDidLoad()
    }
}
