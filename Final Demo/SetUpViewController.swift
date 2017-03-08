//
//  SetUpViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-07.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class SetUpViewController: UIViewController {
    @IBOutlet weak var randomSwitch: UISwitch!
    @IBOutlet weak var weakCardsMoreFrequentSwitch: UISwitch!
    @IBOutlet weak var failedCardsAtEndSwitch: UISwitch!
    @IBOutlet weak var soundCueSwitch: UISwitch!
    let cardManager = CardManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func randomSwitchToggle(_ sender: UISwitch) {
        cardManager.settings.randomMode = sender.isOn
    }

    @IBAction func weakCardsMoreFrequentSwitchToggle(_ sender: UISwitch) {
        cardManager.settings.weakCardsMoreFrequentMode = sender.isOn
    }
    
    @IBAction func failedCardsAtEndSwitchToggle(_ sender: UISwitch) {
        cardManager.settings.failedCardsAtEndMode = sender.isOn
    }
    
    @IBAction func soundCueSwitchToggle(_ sender: UISwitch) {
        cardManager.settings.soundCueMode = sender.isOn
    }
}
