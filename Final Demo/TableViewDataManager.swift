//
//  TableViewDataManager.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-23.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

struct Section {
    var name: String!
    var items: [String]!
    var collapsed: Bool!
    
    init(name: String, items: [String], collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

class TableViewDataManager: NSObject, UITableViewDataSource {
    var activeSection = [Section]()
    var setArray = [String]()
    var categoryArray = [String]()
    var dataArray = [[Double]]()
    var cardManager = CardManager.sharedInstance

    func changeType() {
        createSetArray()
        createCategoryArray()
        resetSections()
    }
    
    func createSetArray() {
        setArray = [String]()
        for set in cardManager.activeArray {
            setArray.append(set.name!)
        }
    }
    
    func createCategoryArray() {
        categoryArray = [String]()
        if cardManager.activeArray.count < 1 {
            return
        }
        let tempArray = cardManager.activeArray[cardManager.setIndex].categoryObjectsArray()
        for category in tempArray {
            categoryArray.append(category.name!)
        }
        resetSections()
    }
    
    func resetSections() {
        var name = ""
        if setArray.count > 0 {
            name = setArray[0]
        }
        
        var category = ""
        if categoryArray.count > 0 {
            category = categoryArray[0]
        }
        activeSection = [Section(name: name, items: setArray),
                         Section(name: category, items: categoryArray)]
    }

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
    
}
