//
//  DownloadManager.swift
//  Final Demo
//
//  Created by Tristan Wolf on 2017-03-01.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {
    
    @IBOutlet weak var textview: UITextView!
    
    
    
    var tempCategoryArray = [String]()
    var categoryArray = [String]()
    var tempSetArray = [String]()
    var setArray = [String]()
    var tempTypeArray = [String]()
    var typeArray = [String]()
    var tempPartArray = [String]()
    var partArray = [String]()
    var helperObjectArray = [HelperObject]()
    
    
    //var lineTestArray = [String]()
    var initialOrderValue:Int16 = 1
    var usedArray = [String]()
    var permanentSetArray = [Sett]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    
    
    
    
    
    @IBAction func api(_ sender: Any) {
        
        let url = URL(string: "https://sheetsu.com/apis/v1.0/5dc5dd109630")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = JSON(data: data!)
                    
                    for (_,subJson):(String, JSON) in json {
                        
                        
                        let category = subJson["Category"].string!
                        let orderString = subJson["Order"].string!
                        let line = subJson["Lines"].string!
                        let part = subJson["Part"].string!
                        let name = subJson["Name"].string!
                        let type = subJson["Type"].string!
                        
                        let order:Int16 = Int16(orderString)!
                        let helperObject: HelperObject = HelperObject()
                        helperObject.line = line
                        helperObject.part = part
                        helperObject.order = order
                        helperObject.category = category
                        
                        self.tempCategoryArray.append(category)
                        self.tempSetArray.append(name)
                        self.tempTypeArray.append(type)
                        self.tempPartArray.append(part)
                        self.helperObjectArray.append(helperObject)
                        self.partArray.append(part)
                        // self.lineTestArray.append(line)
                        
                        self.categoryArray = Array(Set<String>(self.tempCategoryArray))
                        self.setArray = Array(Set<String>(self.tempSetArray))
                        self.typeArray = Array(Set<String>(self.tempTypeArray))
                        self.partArray = Array(Set<String>(self.tempPartArray))
                        
                        
                        
                    }
                    
                }
            }
        }).resume()
        
        
    }
    
    
    @IBAction func makeCards(_ sender: UIButton) {
        
        
        
        let set = Sett(context: DatabaseController.persistentContainer.viewContext)
        
        
        
        set.name = self.setArray[0]
        set.type = self.typeArray[0]
        
        permanentSetArray.append(set)
        
        if set.type == "Script" {
            for categoryObject in self.categoryArray {
                let category = Category(context: DatabaseController.persistentContainer.viewContext)
                category.name = categoryObject
                set.addToCategory(category)
                
                for sectionObject in self.partArray {
                    let section = Section(context: DatabaseController.persistentContainer.viewContext)
                    section.name = sectionObject
                    category.addToSection(section)
                    self.initialOrderValue = 1
                    
                    for helperObject in self.helperObjectArray {
                        self.usedArray.append(helperObject.line)
                        
                        if helperObject.order == self.initialOrderValue {
                            let card = Card(context: DatabaseController.persistentContainer.viewContext)
                            card.answer = helperObject.line
                            card.order = helperObject.order
                            
                            
                            self.initialOrderValue += 1
                            if self.usedArray.count >= 2 {
                                card.question = self.usedArray[self.usedArray.count - 2]
                                
                            } else {
                                card.question = "You have the first line!"
                            }
                            
                            
                            if self.usedArray.count >= 3 {
                                let uneditedCommonPrefix = helperObject.line.commonPrefix(with: self.usedArray[self.usedArray.count - 3])
                                let commonPrefix = uneditedCommonPrefix.components(separatedBy: ":").first
                                
                                if self.categoryArray.contains(commonPrefix!) {
                                    card.isDuet = true
                                }
                                
                            }
                            if self.usedArray.count >= 2 {
                                
                                // something so the 2nd card is marked as isDuet aswell
                            }
                            
                            
                            
                            
                            if helperObject.line.hasPrefix(category.name!), helperObject.part == section.name! {
                                section.addToCard(card)
                                //print(card)
                            }
                            
                            
                        }
                        
                    }
                    // print(section.card?.count ?? "default")
                }
                //print(category.section?.count ?? "default")
            }
            
        } else {
            
            
            for categoryObject in self.categoryArray{
                let category = Category(context: DatabaseController.persistentContainer.viewContext)
                category.name = categoryObject
                set.addToCategory(category)
                
                for sectionObject in self.partArray {
                    let section = Section(context: DatabaseController.persistentContainer.viewContext)
                    section.name = sectionObject
                    
                    
                    for helperObject in self.helperObjectArray {
                        self.usedArray.append(helperObject.line)
                        
                        
                        let card = Card(context: DatabaseController.persistentContainer.viewContext)
                        card.answer = helperObject.line
                        card.order = self.initialOrderValue
                        if self.usedArray.count >= 2 {
                            card.question = self.usedArray[self.usedArray.count - 2]
                        } else {
                            card.question = "You have the first line!"
                        }
                        
                        
                        if category.name == helperObject.category, section.name == helperObject.part {
                            section.addToCard(card)
                            self.initialOrderValue += 1
                            // print(card)
                        }
                        
                        
                    }
                    // print(section.card?.count ?? "empty")
                }
                
            }
        }
        
        
        DatabaseController.saveContext()
        
        //print(set)
        //self.textview.text = self.lineTestArray[0]
        
    }
}
