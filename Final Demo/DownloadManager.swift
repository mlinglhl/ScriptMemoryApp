//
//  DownloadManager.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-01.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreData

class DownloadManager: NSObject {
    
    struct Card {
        var question: String
        var answer: String
        var section: String
        var categoryIndex: Int
        
        init(question: String, answer: String, section: String, categoryIndex: Int) {
            self.question = question
            self.answer = answer
            self.section = section
            self.categoryIndex = categoryIndex
        }
    }
    
    struct CardCategory {
        var name: String
        var sections = [CardSection]()
        var currentSection = ""
        var sectionIndex = 0
        
        init(name: String) {
            self.name = name
        }
    }
    
    struct CardSection {
        var name: String
        var cards = [Card]()
        
        init(name: String) {
            self.name = name
        }
    }
    
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
    var cardArray = [Card]()
    var cardHolder = Card(question: "", answer: "", section: "", categoryIndex: 0)
    var previousCard = Card(question: "", answer: "First line", section: "", categoryIndex: 0)
    var setName = ""
    var setType = ""
    var categories = NSMutableOrderedSet()
    var categoryArray = [CardCategory]()
    
    func makeCardsWithUrl(_ urlString: String, completion: @escaping () -> Void) {
        
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
                if self.setName == "" {
                    self.setName = dict["Name"] ?? ""
                }
                if self.setType == "" {
                    self.setType = dict["Type"] ?? ""
                }
                let dictCategory = dict["Category"] ?? ""
                let whiteSpaceReducedDictCategory = dictCategory.replacingOccurrences(of: ", ", with: ",")
                let tempCategoryArray = whiteSpaceReducedDictCategory.components(separatedBy: ",")
                for category in tempCategoryArray {
                    if !self.categories.contains(category){
                        self.categories.add(category)
                        self.categoryArray.append(CardCategory(name: category))
                    }
                    let categoryIndex = self.categories.index(of: category)
                    var answer = dict["Line"] ?? ""
                    let section = dict["Section"] ?? ""
                    if section != self.previousCard.section {
                        self.previousCard = Card(question: "", answer: "First line", section: "", categoryIndex: 0)
                    }
                    
                    switch self.setType {
                    case "Script":
                        answer = "\(dictCategory): \(answer)"
                        break
                    case "Artist":
                        break
                    default:
                        break
                    }
                    let card = Card(question: self.previousCard.answer, answer: answer, section: section, categoryIndex: categoryIndex)
                    self.cardArray.append(card)
                    self.cardHolder = card
                }
                self.previousCard = self.cardHolder
            }
            self.makeCards()
            DispatchQueue.main.async {
                completion()
            }
        }
        task.resume()
    }
    
    func makeCards() {
        let set = dataManager.generateSetObject()
        
        set.name = self.setName
        set.type = self.setType
        
        for card in cardArray {
            var category = categoryArray[card.categoryIndex]
            if (category.currentSection != card.section) {
                category.sections.append(CardSection(name: card.section))
                category.currentSection = card.section
                category.sectionIndex = category.sections.count - 1
            }
            category.sections[category.sectionIndex].cards.append(card)
            categoryArray[card.categoryIndex] = category
        }
        
        for category in categoryArray {
            let categoryObject = dataManager.generateCategoryObject()
            set.addToCategoryObjects(categoryObject)
            categoryObject.name = category.name
            for section in category.sections {
                let sectionObject = dataManager.generateSectionObject()
                categoryObject.addToSectionObjects(sectionObject)
                sectionObject.name = section.name
                for card in section.cards {
                    let cardObject = dataManager.generateCardObject()
                    sectionObject.addToCardObjects(cardObject)
                    cardObject.question = card.question
                    cardObject.answer = card.answer
                }
            }
        }
        dataManager.saveContext()
    }
}
