//
//  ResultsViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-21.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var index = 0
    var orderedSession = [Int]()
    let cardManager = CardManager.sharedInstance
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderedSession = cardManager.getSessionResults()
        scoreLabel.text = cardManager.getScore()
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red:0.76, green:0.00, blue:0.00, alpha:1.0).cgColor,UIColor(red:0.67, green:0.03, blue:0.04, alpha:1.0).cgColor, UIColor(red:0.57, green:0.06, blue:0.08, alpha:1.0).cgColor,UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor]
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardManager.session.cardRecord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        let session = cardManager.session.cardRecord[orderedSession[indexPath.row]]
        // get the card here with number orderedSession[indexPath.row] and attach its question to the questionLabel
        cell.questionLabel.text = "\(orderedSession[indexPath.row])"
        
        if let session = session {
            if session.0 + session.1 > 0 {
                cell.scoreLabel.text = "\(session.0*100/(session.0+session.1))%"
                return cell
            }
        }
        cell.scoreLabel.text = "No results found"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //grab card at orderedSession[indexPath.row] and add its question and answer
    }
    
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CardViewController" {
            let cvc = segue.destination as! CardViewController
            cvc.cardIndex = resultsTableView.indexPathForSelectedRow!.row
        }
    }
}
