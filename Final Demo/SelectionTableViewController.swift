//
//  SelectionTableViewController.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-26.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class SelectionTableViewController: UIViewController, UITableViewDelegate, CollapsibleTableViewHeaderDelegate {
    @IBOutlet weak var selectionTableView: UITableView!
    @IBOutlet weak var selectionTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    let cardManager = CardManager.sharedInstance
    var tableViewDataManager = TableViewDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDataManager.createSetArray()
        tableViewDataManager.createCategoryArray()
        refreshTableViewHeight()
        selectionTableView.dataSource = tableViewDataManager
        selectionTableView.delegate = self
    }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        cardManager.changeType(typeSegmentedControl.selectedSegmentIndex)
        tableViewDataManager.changeType()
        selectionTableView.reloadData()
        refreshTableViewHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewDataManager.activeSection[indexPath.section].collapsed! ? 0 : 25.0
    }
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = tableViewDataManager.activeSection[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(tableViewDataManager.activeSection[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !tableViewDataManager.activeSection[section].collapsed
        
        // Toggle collapse
        tableViewDataManager.activeSection[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        // Adjust the height of the rows inside the section
        selectionTableView.beginUpdates()
        for i in 0 ..< tableViewDataManager.activeSection[section].items.count {
            selectionTableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
            self.refreshTableViewHeight()
            self.view.layoutIfNeeded()
        }, completion: nil)
        selectionTableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let header = selectionTableView.headerView(forSection: indexPath.section) as! CollapsibleTableViewHeader
        let cell = selectionTableView.cellForRow(at: indexPath)
        header.titleLabel.text = cell!.textLabel!.text
        switch indexPath.section {
        case 0:
            cardManager.setIndex = indexPath.row
            cardManager.categoryIndex = 0
            let header = selectionTableView.headerView(forSection: 1) as! CollapsibleTableViewHeader
            let set = cardManager.activeArray[cardManager.setIndex].categoryObjects
            let categoryObject = set?.object(at: cardManager.categoryIndex) as! CategoryObject
            header.titleLabel.text = categoryObject.name
            break
        case 1:
            cardManager.categoryIndex = indexPath.row
            break
        case 2:
            cardManager.sectionIndex = indexPath.row
        default:
            break
        }
        foldAll()
        tableViewDataManager.createCategoryArray()
    }
    
    func refreshTableViewHeight() {
        var sectionHeight = tableViewDataManager.activeSection.count * 44
        let maxHeight = view.frame.height - 60
        for section in tableViewDataManager.activeSection {
            if let collapsed = section.collapsed {
                if (!collapsed) {
                    sectionHeight += section.items.count * 25
                }
            }
        }
        var floatHeight = CGFloat(sectionHeight)
        if floatHeight > maxHeight {
            floatHeight = maxHeight
        }
        selectionTableViewHeight.constant = floatHeight
    }
    
    func foldAll() {
        let end = tableViewDataManager.activeSection.count - 1
        for index in 0...end {
            let header = selectionTableView.headerView(forSection: index) as! CollapsibleTableViewHeader
            if tableViewDataManager.activeSection[index].collapsed == false {
                toggleSection(header, section: index)
            }
        }
    }
    
}
