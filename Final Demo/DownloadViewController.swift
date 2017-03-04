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

    override func viewDidLoad() {
        super.viewDidLoad()

        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0).cgColor,UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor, UIColor(red:0.29, green:0.13, blue:0.45, alpha:1.0).cgColor]
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
      
        
        
        self.urlTextField.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createCards(_ sender: UIBarButtonItem) {
        self.urlTextField.isHidden = true
        SwiftSpinner.show("Making Cards...")
       
        
       let downloadManager = DownloadManager()
       downloadManager.makeCardsWithUrl(self.urlTextField.text ?? "", completion: {
            let _ = self.navigationController?.popViewController(animated: true)
            SwiftSpinner.hide()
        
        })
    }
    

    

  

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
