//
//  DownloadManager.swift
//  Final Demo
//
//  Created by Tristan Wolf on 2017-03-01.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreData

class DownloadManager: NSObject {
    struct HelperObject {
        var line: String
        var section: String
        var category: String
        
        init(line: String, section: String, category: String) {
            self.line = line
            self.section = section
            self.category = category
        }
    }
    
    @IBOutlet weak var textview: UITextView!
    
    let dataManager = DataManager.sharedInstance
    var tempCategoryArray = [String]()
    var categoryArray = [String]()
    var tempSetArray = [String]()
    var setArray = [String]()
    var tempTypeArray = [String]()
    var typeArray = [String]()
    var tempSectionArray = [String]()
    var sectionArray = [String]()
    var helperObjectArray = [HelperObject]()
    
    
    //var lineTestArray = [String]()
    var orderIndex = 0
    var usedArray = [String]()
    var permanentSetArray = [SetObject]()
    
    
    //sheetsu.com
    //spreadsheet url in makeapi
    //makes it and gives you a url
    
    func makeCardsWithUrl(_ urlString: String) {
        
        let url = URL(string: urlString)
        guard let inputURL = url else {
            return
        }
        let task = URLSession.shared.dataTask(with: inputURL) { (data, response, error) in
            guard let data = data else {
                print ("No data returned from server \(error?.localizedDescription)")
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! Array<Dictionary<String, String>> else {
                print("data returned is not json, or not valid")
                return
            }
            for dict in json {
                let category = dict["Category"] ?? ""
                let line = dict["Line"] ?? ""
                let section = dict["Section"] ?? ""
                let name = dict["Name"] ?? ""
                let type = dict["Type"] ?? ""
                
                let helperObject = HelperObject.init(line: line, section: section, category: category)
                
                self.tempCategoryArray.append(category)
                self.tempSetArray.append(name)
                self.tempTypeArray.append(type)
                self.tempSectionArray.append(section)
                self.helperObjectArray.append(helperObject)
                self.sectionArray.append(section)
                
                self.categoryArray = Array(Set<String>(self.tempCategoryArray))
                self.setArray = Array(Set<String>(self.tempSetArray))
                self.typeArray = Array(Set<String>(self.tempTypeArray))
                self.sectionArray = Array(Set<String>(self.tempSectionArray))
            }
            self.makeCard()
            print("DONE")
        }
        task.resume()
    }
    
    
    func makeCard() {
        let set = dataManager.generateSetObject()
        
        set.name = self.setArray[0]
        set.type = self.typeArray[0]
        
        permanentSetArray.append(set)
        guard let type = set.type else {
            return
        }
        switch type {
        case "Script":
            for categoryObject in self.categoryArray {
                let category = dataManager.generateCategoryObject()
                category.name = categoryObject
                set.addToCategoryObjects(category)
                
                for sectionObject in self.sectionArray {
                    let section = dataManager.generateSectionObject()
                    section.name = sectionObject
                    category.addToSectionObjects(section)
                    self.orderIndex = 1
                    
                    for helperObject in self.helperObjectArray {
                        self.usedArray.append(helperObject.line)
                        
                            let card = dataManager.generateCardObject()
                            card.answer = helperObject.line
                            card.order = Int16(self.orderIndex)
                            
                            self.orderIndex += 1
                            if self.usedArray.count >= 2 {
                                card.question = self.usedArray[self.usedArray.count - 2]
                                print("\(self.orderIndex)")
                            } else {
                                card.question = "You have the first line!"
                            }
                            
                            if self.usedArray.count >= 3 {
                                let uneditedCommonPrefix = helperObject.line.commonPrefix(with: self.usedArray[self.usedArray.count - 3])
                                let commonPrefix = uneditedCommonPrefix.components(separatedBy: ":").first
                                
                                if self.categoryArray.contains(commonPrefix!) {
                                    card.multiPerson = true
                                }
                            }
                            if self.usedArray.count >= 2 {
                                // something so the 2nd card is marked as isDuet aswell
                            }
                            
                            if helperObject.line.hasPrefix(category.name!), helperObject.section == section.name! {
                                section.addToCardObjects(card)
                            }
                    }
                    // print(section.card?.count ?? "default")
                }
                //print(category.section?.count ?? "default")
            }
            break
        case "Artist":
            for categoryObject in self.categoryArray{
                let category = dataManager.generateCategoryObject()
                category.name = categoryObject
                set.addToCategoryObjects(category)
                
                for sectionObject in self.sectionArray {
                    let section = dataManager.generateSectionObject()
                    section.name = sectionObject
                    
                    for helperObject in self.helperObjectArray {
                        self.usedArray.append(helperObject.line)
                        
                        let card = dataManager.generateCardObject()
                        card.answer = helperObject.line
                        card.order = Int16(self.orderIndex)
                        if self.usedArray.count >= 2 {
                            card.question = self.usedArray[self.usedArray.count - 2]
                        } else {
                            card.question = "You have the first line!"
                        }
                        
                        if category.name == helperObject.category, section.name == helperObject.section {
                            section.addToCardObjects(card)
                            self.orderIndex += 1
                        }
                    }
                    // print(section.card?.count ?? "empty")
                }
                
            }
            
            break
        default:
            break
        }
        dataManager.saveContext()    
    }
}
