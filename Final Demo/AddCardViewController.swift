//
//  AddCardViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-20.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class AddCardViewController: SelectionTableViewController {
    
    var constraintArrayScript: [NSLayoutConstraint]!
    var constraintArraySong: [NSLayoutConstraint]!
    
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var setTextField: UITextField!
    
    @IBOutlet weak var questionLabel: UILabel!
  
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sectionLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var categoryLabelLeadingSpaceScript: NSLayoutConstraint!
    
    @IBOutlet weak var questionCharacterTextField: UITextField!
    
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var songLabelHeight: NSLayoutConstraint!
    
    //@IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    @IBOutlet var questionCharacterTextFieldYAnchorScript: NSLayoutConstraint!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet var categoryTextFieldYAnchorScript: NSLayoutConstraint!
    
    @IBOutlet weak var answerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [/*UIColor(hex: 0x2E3944).cgColor,*/ UIColor(red:0.76, green:0.00, blue:0.00, alpha:1.0).cgColor,UIColor(red:0.67, green:0.03, blue:0.04, alpha:1.0).cgColor, UIColor(red:0.57, green:0.06, blue:0.08, alpha:1.0).cgColor,UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor]
        
        newLayer.frame = view.frame
        
        view.layer.addSublayer(newLayer)
        
        view.layer.insertSublayer(newLayer, at: 0)
    }
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.setUIForScript()
            break
        case 1:
            self.setUIForSong()
            break
        default:
            break
        }
    }
    
    @IBAction func saveCard(_ sender: UIButton) {
        let type = typeSegmentedControl.selectedSegmentIndex
        CardManager.sharedInstance.createCardWith(set: setLabel.text!, category: categoryTextField.text!, question: questionLabel.text!, questionSpeaker: questionCharacterTextField.text!, answer: answerTextView.text!, type: type)
        dismiss(animated: true, completion: nil)
    }
    
    func setUIForScript() {
        self.songLabel.isHidden = true
        self.categoryTextField.isHidden = false
        
        for constraint in constraintArraySong {
            constraint.isActive = false
        }
        
        for constraint in constraintArrayScript {
            constraint.isActive = true
        }

        self.questionCharacterTextField.isHidden = false
        self.questionCharacterTextField.placeholder = "Said by..."
        
        self.categoryTextField.placeholder = "Said by..."
        
        self.setLabel.text = "Title:"
        self.songLabelHeight.constant = 0
        self.sectionLabelTopConstraint.constant = 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 20, options: UIViewAnimationOptions.curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    
    func setUIForSong() {
        self.songLabel.isHidden = false

        for constraint in constraintArrayScript {
            constraint.isActive = false
        }
        
        for constraint in constraintArraySong {
            constraint.isActive = true
        }
        
        self.questionCharacterTextField.placeholder = ""
        self.questionCharacterTextField.isHidden = true
        self.categoryTextField.placeholder = ""
        self.sectionLabelTopConstraint.constant = 16 //was 16
        view.layoutIfNeeded()
        self.setLabel.text = "Artist:"
        self.songLabelHeight.constant = 21
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 20, options: UIViewAnimationOptions.curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    
    func setUp() {
        questionTextView.layer.borderColor = UIColor.lightGray.cgColor
        questionTextView.layer.borderWidth = 3
        answerTextView.layer.borderColor = UIColor.lightGray.cgColor
        answerTextView.layer.borderWidth = 3

        constraintArrayScript = [
            categoryLabelLeadingSpaceScript,
            questionCharacterTextFieldYAnchorScript,
            categoryTextFieldYAnchorScript
        ]
        
        constraintArraySong = [
            categoryTextField.leadingAnchor.constraint(equalTo: songLabel.trailingAnchor, constant: 8),
            categoryTextField.centerYAnchor.constraint(equalTo: songLabel.centerYAnchor),
            questionCharacterTextField.centerYAnchor.constraint(equalTo: songLabel.centerYAnchor)
        ]
    }
    
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
