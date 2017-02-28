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
    var manager = CardManager.sharedInstance
    
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
    
    func changeType() {
        createSetArray()
        createCategoryArray()
        activeSection = [Section(name: setArray[0], items: setArray),
                         Section(name: categoryArray[0], items: categoryArray)]
    }
    
    func createSetArray() {
        setArray = [String]()
        for set in manager.sampleActiveArray {
            setArray.append(set.name)
        }
    }
    
    func createCategoryArray() {
        categoryArray = [String]()
        for category in manager.sampleActiveArray[manager.setIndex].categories {
            categoryArray.append(category.name)
        }
        activeSection = [Section(name: setArray[0], items: setArray),
                         Section(name: categoryArray[0], items: categoryArray)]

    }
}
