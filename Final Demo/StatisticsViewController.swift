//
//  StatisticsViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-21.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//
import UIKit
// MARK: - Section Data Structure
//
class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var selectionTableView: UITableView!
    
    @IBOutlet weak var selectionTableViewHeight: NSLayoutConstraint!
    let tableViewDataManager = TableViewDataManager()
    var scriptSection = [Section]()
    var albumSection = [Section]()
    var activeSection = [Section]()
    
    @IBOutlet weak var graphView: ScrollableGraphView!
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    let scriptArray = ["Avenue Q", "Les Miserables", "King Lear", "Lucky Stiff", "Hamlet", "Legally Blonde"]
    let albumArray = ["Thriller", "Back in Black", "The Dark Side of the Moon", "The Bodyguard", "Bat Out of Hell"]
    var activeArray = [String]()
    var dataArray = [[Double]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshTableViewHeight()
        selectionTableView.dataSource = tableViewDataManager
        selectionTableView.delegate = self
        
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
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        let type = typeSegmentedControl.titleForSegment(at: typeSegmentedControl.selectedSegmentIndex)
        tableViewDataManager.changeType(type!)
        selectionTableView.reloadData()
        refreshTableViewHeight()
        graphView.set(data: dataArray[0], withLabels: activeArray)
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
    }
}
