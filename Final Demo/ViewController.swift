//
//  ViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-17.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var scriptLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var scriptLabelHeight: NSLayoutConstraint!
    var scriptFoldedHeight: NSLayoutConstraint!
    var pickerUnfoldedHeight: NSLayoutConstraint!
    @IBOutlet var pickerHeight: NSLayoutConstraint!
    
    let sampleArray = [SampleScript("Avenue Q", author: "Jeff Whitty"),
                       SampleScript("Les Miserables", author: "Victor Hugo"),
                       SampleScript("Lucky Stiff", author: "Lynn Ahrens")]
    let sampleCharacters = ["Harry", "Annabel", "Rita"]
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scriptFoldedHeight = scriptLabel.heightAnchor.constraint(equalToConstant: 0)
        pickerUnfoldedHeight = picker.heightAnchor.constraint(equalToConstant: 100)
        picker.delegate = self
        picker.dataSource = self
        picker.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Characters"
    }
    
    @IBAction func tapScript(_ sender: UITapGestureRecognizer) {
        scriptLabelHeight.isActive = false
        pickerHeight.isActive = false
        scriptFoldedHeight.isActive = true
        pickerUnfoldedHeight.isActive = true
        scriptLabel.isHidden = true
        picker.isHidden = false
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = sampleCharacters[indexPath.row]
        return cell
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sampleArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sampleArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        scriptLabel.text = "Script: \(self.sampleArray[row].name)"
        picker.isHidden = true
        scriptLabel.isHidden = false
        scriptFoldedHeight.isActive = false
        pickerUnfoldedHeight.isActive = false
        scriptLabelHeight.isActive = true
        pickerHeight.isActive = true
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })

    }
}

