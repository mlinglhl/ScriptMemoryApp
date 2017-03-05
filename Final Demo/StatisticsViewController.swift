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
class StatisticsViewController: SelectionTableViewController {
    
    var scriptSection = [Section]()
    var albumSection = [Section]()
    var activeSection = [Section]()
    
    @IBOutlet weak var graphView: ScrollableGraphView!
    
    var setIndex = 0
    var categoryIndex = 0
    var typeIndex = 0
    var typeChanged = false
    
    override func viewDidLoad() {
        setIndex = cardManager.setIndex
        categoryIndex = cardManager.categoryIndex
        typeIndex = cardManager.typeIndex
        cardManager.setIndex = 0
        cardManager.categoryIndex = 0
        cardManager.changeType(0)
        super.viewDidLoad()
        graphView.rangeMax = 100
        graphView.lineColor = UIColor.clear
        graphView.shouldDrawDataPoint = false
        graphView.shouldDrawBarLayer = true
        
        graphView.barWidth = 50
        graphView.barLineWidth = 1
        graphView.barLineColor = UIColor(red:0.20, green:0.60, blue:1.00, alpha:1.0)
        graphView.barColor = UIColor(red:0.20, green:0.60, blue:1.00, alpha:1.0)
        graphView.backgroundFillColor = UIColor(red:0.57, green:0.06, blue:0.08, alpha:1.0)
        
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
        graphView.set(data: cardManager.getDataForSelectedTableViewSection(0), withLabels: cardManager.getLabelsForSelectedTableViewSection(0))
        view.addSubview(graphView)
    }

    @IBAction override func changeSegment(_ sender: UISegmentedControl) {
        super.changeSegment(sender)
        graphView.set(data: cardManager.getDataForSelectedTableViewSection(0), withLabels: cardManager.getLabelsForSelectedTableViewSection(0))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
            graphView.set(data: cardManager.getDataForSelectedTableViewSection(indexPath.section), withLabels: cardManager.getLabelsForSelectedTableViewSection(indexPath.section))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cardManager.changeType(typeIndex)
        cardManager.setIndex = setIndex
        cardManager.categoryIndex = categoryIndex
    }
    
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
}
