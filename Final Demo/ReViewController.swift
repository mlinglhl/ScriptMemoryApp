//
//  ReViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-08.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class ReViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var reviewTableView: UITableView!
    let cardManager = CardManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0).cgColor,UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor, UIColor(red:0.29, green:0.13, blue:0.45, alpha:1.0).cgColor]
        
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardManager.getCardArray()!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell", for: indexPath) as! ResultsTableViewCell
        let cards = cardManager.getCardArray()
        guard let currentCards = cards else {
            return cell
        }
        let card = currentCards[indexPath.row]
        let question = card.question ?? ""
        cell.questionLabel.text = "\(question)"
        
            if card.correct + card.wrong > 0 {
                cell.scoreLabel.text = "\(card.correct*100/(card.correct+card.wrong))%"
                return cell
            }
        cell.scoreLabel.text = "0%"
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CardViewController" {
            let cvc = segue.destination as! CardViewController
            cvc.cardIndex = reviewTableView.indexPathForSelectedRow!.row
        }
    }
}
