//
//  StatisticsViewControllerTableViewExtension.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-22.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource, CollapsibleTableViewHeaderDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return activeSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeSection[section].items.count
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = activeSection[indexPath.section].items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return activeSection[indexPath.section].collapsed! ? 0 : 25.0
    }
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = activeSection[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(activeSection[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !activeSection[section].collapsed
        
        // Toggle collapse
        activeSection[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        // Adjust the height of the rows inside the section
        optionsTableView.beginUpdates()
        for i in 0 ..< activeSection[section].items.count {
            optionsTableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        refreshTableViewHeight()
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        optionsTableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let header = optionsTableView.headerView(forSection: 1) as! CollapsibleTableViewHeader
            if activeSection[1].collapsed == false {
                toggleSection(header, section: 1)
            }
            header.titleLabel.text = "All"
        }
        let header = optionsTableView.headerView(forSection: indexPath.section) as! CollapsibleTableViewHeader
        let cell = optionsTableView.cellForRow(at: indexPath)
        toggleSection(header, section: indexPath.section)
        header.titleLabel.text = cell!.textLabel!.text
    }
    
    func refreshTableViewHeight() {
        var sectionHeight = activeSection.count * 44
        let maxHeight = view.frame.height - 60
        for section in activeSection {
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
        optionsTableViewHeight.constant = floatHeight
    }
    
}
