//
//  EditScriptViewController.swift
//  Final Demo
//
//  Created by Tristan Wolf on 2017-03-06.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import Foundation
import UIKit

class EditScriptViewController: SelectionTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUp()
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red:0.76, green:0.00, blue:0.00, alpha:1.0).cgColor,UIColor(red:0.67, green:0.03, blue:0.04, alpha:1.0).cgColor, UIColor(red:0.57, green:0.06, blue:0.08, alpha:1.0).cgColor,UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor]
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
