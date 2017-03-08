//
//  DownloadViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-01.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
//import SwiftSpinner

class DownloadViewController: UIViewController {
   
    @IBOutlet weak var urlTextField: UITextField!
    
    var progressTimer: Timer!
    var delegate: RefreshDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0).cgColor,UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor, UIColor(red:0.29, green:0.13, blue:0.45, alpha:1.0).cgColor]
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
      
        self.urlTextField.isHidden = false
    }
    
    @IBAction func createCards(_ sender: UIBarButtonItem) {
        self.urlTextField.isHidden = true
        SwiftSpinner.show("Making Cards...")
        
       let downloadManager = DownloadManager()
       downloadManager.makeCardsWithUrl(self.urlTextField.text ?? "", completion: {
            let _ = self.navigationController?.popViewController(animated: true)
            self.delegate.refreshTableView()
            SwiftSpinner.hide()
        })
    }
}
