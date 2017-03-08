//
//  EditScriptViewController.swift
//  Final Demo
//
//  Created by Tristan Wolf on 2017-03-06.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class AddCardViewController: SelectionTableViewController {
    var delegate: RefreshDelegate!
    
    @IBOutlet weak var setLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var questionTextView: TextViewStyleManager!
    
    @IBOutlet weak var answerTextView: TextViewStyleManager!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var questionSpeakerTextField: UITextField!
    @IBOutlet weak var answerSpeakerTextField: UITextField!
    
    var collapsibleTableViewHeader: CollapsibleTableViewHeader!
    
    @IBOutlet weak var newSetTextField: UITextField!
    @IBOutlet weak var newCategoryTextField: UITextField!
    @IBOutlet weak var newSectionTextField: UITextField!
    @IBOutlet weak var chooseSetButton: UIBarButtonItem!
    @IBOutlet weak var newSetButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newSetTextField.isHidden = true
        self.newCategoryTextField.isHidden = true
        self.newSectionTextField.isHidden = true
        self.chooseSetButton.isEnabled = false
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red:0.29, green:0.13, blue:0.45, alpha:1.0).cgColor, UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor]
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
    }
    @IBAction func addSet(_ sender: UIBarButtonItem) {
        self.selectionTableView.isHidden = true
        self.newSetTextField.isHidden = false
        self.newCategoryTextField.isHidden = false
        self.newSectionTextField.isHidden = false
        self.chooseSetButton.isEnabled = true
        self.newSetButton.isEnabled = false
    }
    
    @IBAction func setFromLibrary(_ sender: UIBarButtonItem) {
        self.selectionTableView.isHidden = false
        self.newSetTextField.isHidden = true
        self.newCategoryTextField.isHidden = true
        self.newSectionTextField.isHidden = true
        self.chooseSetButton.isEnabled = false
        self.newSetButton.isEnabled = true
    }
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.setUIForScript()
            changeSegment(segmentedControl)
            break
        case 1:
            self.setUIForArtist()
            changeSegment(segmentedControl)
            break
        default:
            break
        }
    }
    
    @IBAction func saveCard(_ sender: UIButton) {
        if self.chooseSetButton.isEnabled == true {
            if newSetTextField.text != "" && newCategoryTextField.text != "" && newSectionTextField.text != "" && questionTextView.text != "" && answerTextView.text != "" {
                cardManager.createCardWith(set: newSetTextField.text!, category: newCategoryTextField.text!, section: newSectionTextField.text!, question: questionTextView.text!, questionSpeaker: questionSpeakerTextField.text!, answer: answerTextView.text!, answerSpeaker: answerSpeakerTextField.text!)
                delegate.refreshTableView()
                _ = navigationController?.popViewController(animated: true)
                return
            }
            else {
                if newSetTextField.text == "" {
                    newSetTextField.placeholder = "This field is required"
                }
                if newCategoryTextField.text == "" {
                    newCategoryTextField.placeholder = "This field is required"
                }
                if newSectionTextField.text == "" {
                    newSectionTextField.placeholder = "This field is required"
                }
                if questionTextView.text == "" {
                    questionTextView.text = "This field is required"
                }
                if answerTextView.text == "" {
                    answerTextView.text = "This field is required"
                }
                return
            }
        }
        if questionTextView.text != "" && answerTextView.text != "" {
            cardManager.createCardWithCurrentSettingsAnd(question: questionTextView.text!, questionSpeaker: questionSpeakerTextField.text!, answer: answerTextView.text!, answerSpeaker: answerSpeakerTextField.text!)
            delegate.refreshTableView()
            _ = navigationController?.popViewController(animated: true)
            return
        }
        if questionTextView.text == "" {
            questionTextView.text = "This field is required"
        }
        if answerTextView.text == "" {
            answerTextView.text = "This field is required"
        }
    }
    
    func setUIForScript() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
            self.setLabel.text = "Title:"
            self.categoryLabel.text = "Character:"
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    
    func setUIForArtist() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
            self.setLabel.text = "Artist:"
            self.categoryLabel.text = "Song:"
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
