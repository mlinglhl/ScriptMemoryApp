//
//  AddCardViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-20.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController {
    
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var setTextField: UITextField!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionCharacterTextField: UITextField!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var songLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    @IBOutlet var questionCharacterTextFieldScriptYAnchor: NSLayoutConstraint!
    var questionCharacterTextFieldSongYAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet var categoryTextFieldScriptYAnchor: NSLayoutConstraint!
    var categoryTextFieldSongYAnchor: NSLayoutConstraint!

    @IBOutlet weak var answerTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTextFieldSongYAnchor = categoryTextField.centerYAnchor.constraint(equalTo: songLabel.centerYAnchor)
        questionCharacterTextFieldSongYAnchor = questionCharacterTextField.centerYAnchor.constraint(equalTo: songLabel.centerYAnchor)
        questionTextView.layer.borderColor = UIColor.lightGray.cgColor
        questionTextView.layer.borderWidth = 3
        answerTextView.layer.borderColor = UIColor.lightGray.cgColor
        answerTextView.layer.borderWidth = 3
    }
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
        switch sender.titleForSegment(at: sender.selectedSegmentIndex)! {
        case "Script":
            self.songLabel.isHidden = true
            self.categoryTextField.isHidden = false
            self.questionCharacterTextField.isHidden = false
            self.questionCharacterTextFieldSongYAnchor.isActive = false
            self.questionCharacterTextFieldScriptYAnchor.isActive = true
            self.questionCharacterTextField.placeholder = "Said by..."

            self.categoryTextFieldSongYAnchor.isActive = false
            self.categoryTextFieldScriptYAnchor.isActive = true
            self.categoryTextField.placeholder = "Said by..."
            
            self.setLabel.text = "Title:"
            self.songLabelHeight.constant = 0
            self.questionLabelTopConstraint.constant = 0
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 20, options: UIViewAnimationOptions.curveLinear, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                })
            break
        case "Song":
            self.songLabel.isHidden = false
            self.questionCharacterTextFieldScriptYAnchor.isActive = false
            self.questionCharacterTextFieldSongYAnchor.isActive = true
            self.questionCharacterTextField.placeholder = ""
            self.questionCharacterTextField.isHidden = true
            self.categoryTextFieldScriptYAnchor.isActive = false
            self.categoryTextFieldSongYAnchor.isActive = true
            self.categoryTextField.placeholder = ""
            self.questionLabelTopConstraint.constant = 16
            view.layoutIfNeeded()
            self.setLabel.text = "Artist:"
            self.songLabelHeight.constant = 21
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 20, options: UIViewAnimationOptions.curveLinear, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
            })
            break
        default:
            break
        }
    }
    
    @IBAction func cancelNewCard(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveCard(_ sender: UIButton) {
        var type = typeSegmentedControl.titleForSegment(at: typeSegmentedControl.selectedSegmentIndex)
        if type == "Song" {
            type = "Artist"
        }

        CardManager.sharedInstance.createCardWith(set: setLabel.text!, category: categoryTextField.text!, question: questionLabel.text!, questionSpeaker: questionCharacterTextField.text!, answer: answerTextView.text!, type: type!)
        dismiss(animated: true, completion: nil)
    }
}
