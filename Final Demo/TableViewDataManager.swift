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
    var sectionArray = [String]()
    var dataArray = [[Double]]()
    var cardManager = CardManager.sharedInstance

    func changeType() {
        updateData()
    }
    
    func updateData() {
        createSetArray()
        createCategoryArray()
        createSectionArray()
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
        let categories = cardManager.activeArray[cardManager.setIndex].categoryObjectsArray()
        for category in categories {
            categoryArray.append(category.name!)
        }
    }
    
    func createSectionArray() {
        sectionArray = [String]()
        if cardManager.activeArray.count < 1 {
            return
        }
        if cardManager.activeArray[cardManager.setIndex].categoryObjectsArray().count < 1 {
            return
        }
        let categories = cardManager.activeArray[cardManager.setIndex].categoryObjectsArray()
        let sections = categories[cardManager.categoryIndex].sectionObjectsArray()
        for section in sections {
            sectionArray.append(section.name!)
        }
    }
    
    func resetSections() {
        var name = ""
        if setArray.count > 0 {
            name = setArray[cardManager.setIndex]
        }
        
        var category = ""
        if categoryArray.count > 0 {
            category = categoryArray[cardManager.categoryIndex]
        }
        
        var section = ""
        if sectionArray.count > 0 {
            section = sectionArray[cardManager.sectionIndex]
        }
        activeSection = [Section(name: name, items: setArray),
                         Section(name: category, items: categoryArray),
                         Section(name: section, items: sectionArray)]
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Baleeten")
        }
    }
}

//
//override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//    if editingStyle == .Delete {
//        let context = self.fetchedResultsController.managedObjectContext
//        context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
//        
//        do {
//            try context.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            //print("Unresolved error \(error), \(error.userInfo)")
//            abort()
//        }
//    }
//}
