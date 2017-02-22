//
//  StatisticsViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-21.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var graphView: ScrollableGraphView!
    
    @IBOutlet weak var nameTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var categoryTypeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    @IBOutlet weak var categorySwitch: UISwitch!
    
    
    @IBOutlet weak var namePickerView: UIPickerView!
    @IBOutlet weak var nameLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pickerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var namePickerViewHeight: NSLayoutConstraint!
    let scriptArray = ["Avenue Q", "Les Miserables", "King Lear", "Lucky Stiff", "Hamlet", "Legally Blonde"]
    let albumArray = ["Thriller", "Back in Black", "The Dark Side of the Moon", "The Bodyguard", "Bat Out of Hell"]
    var activeArray = [String]()
    var dataArray = [[Double]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        categorySwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        activeArray = scriptArray
        let data: [Double] = [12/17*100, 23/25*100, 13/16*100, 24/36*100, 13/14*100, 12/100*100]
        let data2: [Double] = [7/17*100, 21/25*100, 14/16*100, 33/36*100, 2/14*100, 88/100*100]
        let data3: [Double] = [15/17*100, 17/25*100, 8/16*100, 12/36*100, 10/14*100, 85/100*100]
        let data4: [Double] = [14/17*100, 20/25*100, 16/16*100, 35/36*100, 12/14*100, 95/100*100]
        let data5: [Double] = [10/17*100, 12/25*100, 11/16*100, 21/36*100, 5/14*100, 65/100*100]
        let data6: [Double] = [17/17*100, 22/25*100, 12/16*100, 11/36*100, 14/14*100, 95/100*100]
        dataArray.append(data)
        dataArray.append(data2)
        dataArray.append(data3)
        dataArray.append(data4)
        dataArray.append(data5)
        dataArray.append(data6)

        graphView.rangeMax = 100
        graphView.lineColor = UIColor.clear
        graphView.shouldDrawDataPoint = false
        graphView.shouldDrawBarLayer = true
        
        graphView.barWidth = 50
        graphView.barLineWidth = 1
        graphView.barLineColor = UIColor.blue
        graphView.barColor = UIColor.blue
        graphView.backgroundFillColor = UIColor.purple
        
        graphView.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        graphView.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        graphView.referenceLineLabelColor = UIColor.white
        graphView.numberOfIntermediateReferenceLines = 4
        graphView.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        graphView.dataPointSpacing = 100
        
        graphView.shouldAnimateOnStartup = true
        graphView.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        graphView.animationDuration = 1.5
        graphView.rangeMax = 100
        graphView.shouldRangeAlwaysStartAtZero = true
        graphView.set(data:dataArray[0], withLabels: activeArray)
        view.addSubview(graphView)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activeArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activeArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        graphView.set(data: dataArray[row], withLabels: activeArray)
        nameLabelHeight.constant = 21
        namePickerViewHeight.constant = 0
        nameLabel.isHidden = false
        namePickerView.isHidden = true
        let type = typeSegmentedControl.titleForSegment(at: typeSegmentedControl.selectedSegmentIndex)
        let name = activeArray[namePickerView.selectedRow(inComponent: 0)]
        nameLabel.text = "\(type!): \(name)"

        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        let type = typeSegmentedControl.titleForSegment(at: typeSegmentedControl.selectedSegmentIndex)
        switch type! {
        case "Script":
            activeArray = scriptArray
            break
        case "Album":
            activeArray = albumArray
            break
        default:
            break
        }
        namePickerView.reloadAllComponents()
        graphView.set(data: dataArray[0], withLabels: activeArray)
        namePickerView.selectRow(0, inComponent: 0, animated: false)
        let name = activeArray[namePickerView.selectedRow(inComponent: 0)]
        nameTypeLabel.text = "\(type!):"
        nameLabel.text = "\(name)"
    }
    
    @IBAction func openMenu(_ sender: UITapGestureRecognizer) {
        nameLabelHeight.constant = 0
        namePickerViewHeight.constant = 200
        nameLabel.isHidden = true
        namePickerView.isHidden = false
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
