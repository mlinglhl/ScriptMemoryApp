//
//  SetUpViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-07.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class SetUpViewController: UIViewController {
    @IBOutlet weak var failedCardsAtEndSwitch: UISwitch!
    @IBOutlet weak var soundCueSwitch: UISwitch!
    @IBOutlet weak var randomSwitch: UISwitch!
    @IBOutlet weak var weakCardsMoreFrequentLabel: UILabel!
    @IBOutlet weak var weakCardsMoreFrequentSwitch: UISwitch!
    let cardManager = CardManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        failedCardsAtEndSwitch.isOn = cardManager.settings.failedCardsAtEndMode
        soundCueSwitch.isOn = cardManager.settings.soundCueMode
        randomSwitch.isOn = cardManager.settings.randomMode
        weakCardsMoreFrequentSwitch.isOn = cardManager.settings.weakCardsMoreFrequentMode
        weakCardsMoreFrequentSwitch.isHidden = !randomSwitch.isOn
        weakCardsMoreFrequentLabel.isHidden = !randomSwitch.isOn
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0).cgColor,UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor, UIColor(red:0.29, green:0.13, blue:0.45, alpha:1.0).cgColor]
        
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
    }

    @IBAction func failedCardsAtEndSwitchToggle(_ sender: UISwitch) {
        cardManager.settings.failedCardsAtEndMode = sender.isOn
    }
    
    @IBAction func soundCueSwitchToggle(_ sender: UISwitch) {
        cardManager.settings.soundCueMode = sender.isOn
    }

    @IBAction func randomSwitchToggle(_ sender: UISwitch) {
        cardManager.settings.randomMode = sender.isOn
        weakCardsMoreFrequentSwitch.isHidden = !sender.isOn
        weakCardsMoreFrequentLabel.isHidden = !sender.isOn
    }

    @IBAction func weakCardsMoreFrequentSwitchToggle(_ sender: UISwitch) {
        cardManager.settings.weakCardsMoreFrequentMode = sender.isOn
    }
}
