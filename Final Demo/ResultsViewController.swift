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
//        cardManager.trimExtraCards()
        super.viewDidLoad()
  //      orderedSession = cardManager.getSessionResults()
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
        let cards = cardManager.getCardArray()
        guard let currentCards = cards else {
            return 0
        }
        return currentCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        let cards = cardManager.getCardArray()
        guard let currentCards = cards else {
            return cell
        }
        let card = currentCards[indexPath.row]
//        let card = cardManager.session.deck[indexPath.row]
        let session = cardManager.session.cardRecord[Int(card.index)]
        // get the card here with number orderedSession[indexPath.row] and attach its question to the questionLabel
        let question = card.question ?? ""
        cell.questionLabel.text = "\(question)"
        
        if let session = session {
            if session.0 + session.1 > 0 {
                cell.scoreLabel.text = "\(session.0*100/(session.0+session.1))%"
                return cell
            }
        }
        cell.scoreLabel.text = "0%"
        return cell
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        cardManager.restoreExtraCards()
    }
}
