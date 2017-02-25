//
//  AddCardViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-20.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController {
    
    var constraintArrayScript: [NSLayoutConstraint]!
    var constraintArraySong: [NSLayoutConstraint]!
    
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var setTextField: UITextField!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var sectionLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var categoryLabelLeadingSpaceScript: NSLayoutConstraint!
    
    @IBOutlet weak var questionCharacterTextField: UITextField!
    
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var songLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    @IBOutlet var questionCharacterTextFieldYAnchorScript: NSLayoutConstraint!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet var categoryTextFieldYAnchorScript: NSLayoutConstraint!
    
    @IBOutlet weak var answerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
        switch sender.titleForSegment(at: sender.selectedSegmentIndex)! {
        case "Script":
            self.setUIForScript()
            break
        case "Song":
            self.setUIForSong()
            break
        default:
            break
        }
    }
    
    @IBAction func saveCard(_ sender: UIButton) {
        var type = typeSegmentedControl.titleForSegment(at: typeSegmentedControl.selectedSegmentIndex)
        if type == "Song" {
            type = "Artist"
        }
        CardManager.sharedInstance.createCardWith(set: setLabel.text!, category: categoryTextField.text!, question: questionLabel.text!, questionSpeaker: questionCharacterTextField.text!, answer: answerTextView.text!, type: type!)
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
        self.sectionLabelTopConstraint.constant = 16
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
}
