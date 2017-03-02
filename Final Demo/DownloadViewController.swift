//
//  DownloadViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-01.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {
<<<<<<< HEAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
=======
    @IBOutlet weak var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let newLayer = CAGradientLayer()
        newLayer.colors = [/*UIColor(hex: 0x2E3944).cgColor,*/ UIColor(red:0.76, green:0.00, blue:0.00, alpha:1.0).cgColor,UIColor(red:0.67, green:0.03, blue:0.04, alpha:1.0).cgColor, UIColor(red:0.57, green:0.06, blue:0.08, alpha:1.0).cgColor,UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor]
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
        
        self.progressView.progress = 0
            }

>>>>>>> 37ce6f4a4b35337c9412b8291551b42ead8e9e36
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createCards(_ sender: UIBarButtonItem) {
        let downloadManager = DownloadManager()
<<<<<<< HEAD
        downloadManager.makeCardsWithUrl("https://sheetsu.com/apis/v1.0/be01e80a78d1", completion: {
            let _ = self.navigationController?.popViewController(animated: true)
        })
=======
        downloadManager.makeCardsWithUrl("https://sheetsu.com/apis/v1.0/be01e80a78d1")
        self.progressView.progress = 1
>>>>>>> 37ce6f4a4b35337c9412b8291551b42ead8e9e36
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
