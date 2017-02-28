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
        graphView.set(data: cardManager.getCategoryDataAtIndex(0), withLabels: tableViewDataManager.categoryArray)
        view.addSubview(graphView)
        markCategoryHeaderAsAll()
    }
    
    @IBAction override func changeSegment(_ sender: UISegmentedControl) {
        super.changeSegment(sender)
        graphView.set(data: cardManager.getCategoryDataAtIndex(0), withLabels: tableViewDataManager.categoryArray)
        markCategoryHeaderAsAll()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        if indexPath.section == 0 {
            graphView.set(data: cardManager.getCategoryDataAtIndex(0), withLabels: tableViewDataManager.categoryArray)
            markCategoryHeaderAsAll()
            return
        }
        graphView.set(data: cardManager.getCardDataAtIndex(indexPath.row), withLabels: cardManager.getCardLabels())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cardManager.typeIndex = typeIndex
        cardManager.changeType(typeIndex)
        cardManager.setIndex = setIndex
        cardManager.categoryIndex = categoryIndex
    }
    
    func markCategoryHeaderAsAll() {
        let header = selectionTableView.headerView(forSection: 1) as! CollapsibleTableViewHeader
        header.titleLabel.text = "All"
    }
}
