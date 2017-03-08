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
    @IBOutlet weak var setLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var questionCharacterTextField: UITextField!
 
    @IBOutlet weak var questionTextView: TextViewStyleManager!
    
    @IBOutlet weak var answerCharacterTextField: UITextField!
    
    @IBOutlet weak var answerTextView: TextViewStyleManager!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    

    var collapsibleTableViewHeader: CollapsibleTableViewHeader!
  
    @IBOutlet weak var newScriptTextField: UITextField!
    @IBOutlet weak var newCategoryTextField: UITextField!
    @IBOutlet weak var newSectionTextField: UITextField!
    @IBOutlet weak var chooseSetButton: UIBarButtonItem!
    @IBOutlet weak var newSetButton: UIBarButtonItem!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUp()
        self.answerCharacterTextField.isHidden = true
        self.newScriptTextField.isHidden = true
        self.newCategoryTextField.isHidden = true
        self.newSectionTextField.isHidden = true
        self.chooseSetButton.isEnabled = false
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red:0.29, green:0.13, blue:0.45, alpha:1.0).cgColor, UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor, UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0).cgColor]
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
    }
    @IBAction func addSet(_ sender: UIBarButtonItem) {
        self.selectionTableView.isHidden = true
        self.newScriptTextField.isHidden = false
        self.newCategoryTextField.isHidden = false
        self.newSectionTextField.isHidden = false
        self.chooseSetButton.isEnabled = true
        self.newSetButton.isEnabled = false
    }
    
    @IBAction func setFromLibrary(_ sender: UIBarButtonItem) {
        self.selectionTableView.isHidden = false
        self.newScriptTextField.isHidden = true
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
            self.setUIForSong()
            changeSegment(segmentedControl)
            break
        default:
            break
        }
    }
    
    @IBAction func saveCard(_ sender: UIButton) {
        
        if self.chooseSetButton.isEnabled == true {
            
            let type = typeSegmentedControl.selectedSegmentIndex
            CardManager.sharedInstance.createCardWith(set: newScriptTextField.text!, category: newCategoryTextField.text!, question: questionTextView.text!, questionSpeaker: questionCharacterTextField.text!, answer: answerTextView.text!, type: type)
            dismiss(animated: true, completion: nil)
            
            
        } else if self.chooseSetButton.isEnabled == false {
        
        /*let type = typeSegmentedControl.selectedSegmentIndex
        CardManager.sharedInstance.createCardWith(set:, category:, question: questionTextView.text!, questionSpeaker: questionCharacterTextField.text!, answer: answerTextView.text!, type: type)
        
            dismiss(animated: true, completion: nil)*/
        }
    }
    
    func setUIForScript() {
       // self.songLabel.isHidden = true
        
        // for constraint in constraintArraySong {
        //     constraint.isActive = false
        // }
        
        // for constraint in constraintArrayScript {
        //     constraint.isActive = true
        // }
        
        self.questionCharacterTextField.isHidden = false
        self.questionCharacterTextField.placeholder = "Said by..."
        
       // self.categoryTextField.placeholder = "Said by..."
        
        self.setLabel.text = "Title:"
        self.categoryLabel.text = "Character:"
        //self.songLabelHeight.constant = 0
        //self.sectionLabelTopConstraint.constant = 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 20, options: UIViewAnimationOptions.curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    
    func setUIForSong() {
       
       // self.songLabel.isHidden = false
        
        //  for constraint in constraintArrayScript {
        //      constraint.isActive = false
        // }
        
        // for constraint in constraintArraySong {
        //     constraint.isActive = true
        // }
        
       // self.questionCharacterTextField.placeholder = ""
        self.questionCharacterTextField.isHidden = true
       // self.categoryTextField.placeholder = ""
        //self.sectionLabelTopConstraint.constant = 16
        view.layoutIfNeeded()
        self.setLabel.text = "Artist:"
        self.categoryLabel.text = "Song:"
        //self.songLabelHeight.constant = 21
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 20, options: UIViewAnimationOptions.curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    
  //  func setUp() {
        // questionTextView.layer.borderColor = UIColor.lightGray.cgColor
        //questionTextView.layer.borderWidth = 3
        //answerTextView.layer.borderColor = UIColor.lightGray.cgColor
        // answerTextView.layer.borderWidth = 3
        
        /*constraintArrayScript = [
         categoryLabelLeadingSpaceScript,
         questionCharacterTextFieldYAnchorScript,
         categoryTextFieldYAnchorScript
         ]*/
        
       // constraintArraySong = [
       //     categoryTextField.leadingAnchor.constraint(equalTo: songLabel.trailingAnchor, constant: 8),
       //     categoryTextField.centerYAnchor.constraint(equalTo: songLabel.centerYAnchor),
        //    questionCharacterTextField.centerYAnchor.constraint(equalTo: songLabel.centerYAnchor)
       // ]
   // }
    
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        _ = navigationController?.popToRootViewController(animated: true)
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
}
