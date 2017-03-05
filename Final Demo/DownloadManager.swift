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
        let question: String
        let answer: String
        let section: String
        let categoryIndex: Int
        let questionSpeaker: String
        let answerSpeaker: String
        let multiPerson: Bool
        
        init(question: String, answer: String, section: String, categoryIndex: Int, questionSpeaker: String, answerSpeaker: String, multiPerson: Bool) {
            self.question = question
            self.answer = answer
            self.section = section
            self.categoryIndex = categoryIndex
            self.questionSpeaker = questionSpeaker
            self.answerSpeaker = answerSpeaker
            self.multiPerson = multiPerson
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
    var cardHolder = Card(question: "", answer: "", section: "", categoryIndex: 0, questionSpeaker: "", answerSpeaker: "", multiPerson: false)
    var previousCard = Card(question: "", answer: "First line", section: "", categoryIndex: 0, questionSpeaker: "", answerSpeaker: "", multiPerson: false)
    var setName = ""
    var setType = ""
    var categories = NSMutableOrderedSet()
    var categoryArray = [CardCategory]()
    var allCategorySection: SectionObject!
    
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
                var dictCategory = dict["Category"] ?? ""
                if dictCategory == "" {
                    dictCategory = self.previousCard.answerSpeaker
                }
                let whiteSpaceReducedDictCategory = dictCategory.replacingOccurrences(of: ", ", with: ",")
                let tempCategoryArray = whiteSpaceReducedDictCategory.components(separatedBy: ",")
                for category in tempCategoryArray {
                    if !self.categories.contains(category){
                        self.categories.add(category)
                        self.categoryArray.append(CardCategory(name: category))
                    }
                    let categoryIndex = self.categories.index(of: category)
                    let answer = dict["Line"] ?? ""
                    var section = dict["Section"] ?? ""
                    if section == "" {
                        section = self.previousCard.section
                    }
                    if section != self.previousCard.section {
                        self.previousCard = Card(question: "", answer: "First line", section: "", categoryIndex: 0, questionSpeaker: "", answerSpeaker: "", multiPerson: false)
                    }
                    var multiPerson = false
                    if self.previousCard.answerSpeaker != dictCategory {
                        multiPerson = true
                    }
                    let card = Card(question: self.previousCard.answer, answer: answer, section: section, categoryIndex: categoryIndex, questionSpeaker: self.previousCard.answerSpeaker, answerSpeaker: dictCategory, multiPerson: multiPerson)
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
        
        let allCategory = dataManager.generateCategoryObject()
        allCategory.name = "All"
        set.addToCategoryObjects(allCategory)
        var currentAllCategorySection = ""
        for category in categoryArray {
            let categoryObject = dataManager.generateCategoryObject()
            set.addToCategoryObjects(categoryObject)
            categoryObject.name = category.name
            for section in category.sections {
                let sectionObject = dataManager.generateSectionObject()
                categoryObject.addToSectionObjects(sectionObject)
                sectionObject.name = section.name
                if currentAllCategorySection != section.name || allCategorySection == nil {
                    allCategorySection = dataManager.generateSectionObject()
                    allCategorySection.name = section.name
                    allCategory.addToSectionObjects(allCategorySection)
                    currentAllCategorySection = section.name
                }
                for card in section.cards {
                    let cardObject = dataManager.generateCardObject()
                    sectionObject.addToCardObjects(cardObject)
                    allCategorySection.addToCardObjects(cardObject)
                    cardObject.question = card.question
                    cardObject.answer = card.answer
                    cardObject.questionSpeaker = card.questionSpeaker
                    cardObject.answerSpeaker = card.answerSpeaker
                    cardObject.multiPerson = card.multiPerson
                }
            }
        }
        dataManager.saveContext()
    }
}
