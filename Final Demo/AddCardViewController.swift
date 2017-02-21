//
//  AddCardViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-20.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var writerTextField: UITextField!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionCharacterTextField: UITextField!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var songLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    @IBOutlet var questionCharacterTextFieldScriptYAnchor: NSLayoutConstraint!
    var questionCharacterTextFieldSongYAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var divisionTextField: UITextField!
    @IBOutlet var divisionTextFieldScriptYAnchor: NSLayoutConstraint!
    var divisionTextFieldSongYAnchor: NSLayoutConstraint!
    var divisionText = String()

    @IBOutlet weak var answerTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        divisionTextFieldSongYAnchor = divisionTextField.centerYAnchor.constraint(equalTo: songLabel.centerYAnchor)
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
            self.divisionTextField.isHidden = false
            self.questionCharacterTextField.isHidden = false
            self.questionCharacterTextFieldSongYAnchor.isActive = false
            self.questionCharacterTextFieldScriptYAnchor.isActive = true
            self.questionCharacterTextField.placeholder = "Said by..."

            self.divisionTextFieldSongYAnchor.isActive = false
            self.divisionTextFieldScriptYAnchor.isActive = true
            self.divisionTextField.placeholder = "Said by..."
            
            self.nameLabel.text = "Title:"
            self.writerLabel.text = "Writer:"
            self.songLabelHeight.constant = 0
            self.questionLabelTopConstraint.constant = 0
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
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
            self.divisionTextFieldScriptYAnchor.isActive = false
            self.divisionTextFieldSongYAnchor.isActive = true
            self.divisionTextField.placeholder = ""
            self.nameLabel.text = "Album:"
            self.writerLabel.text = "Artist:"
            self.songLabelHeight.constant = 21
            self.questionLabelTopConstraint.constant = 16
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
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
}
