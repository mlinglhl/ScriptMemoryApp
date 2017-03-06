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
        let index: Int
        
        init(question: String, answer: String, section: String, categoryIndex: Int, questionSpeaker: String, answerSpeaker: String, index: Int) {
            self.question = question
            self.answer = answer
            self.section = section
            self.categoryIndex = categoryIndex
            self.questionSpeaker = questionSpeaker
            self.answerSpeaker = answerSpeaker
            self.index = index
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
    
    let dataManager = DataManager.sharedInstance
    var cardArray = [Card]()
    var cardHolder = Card(question: "", answer: "", section: "", categoryIndex: 0, questionSpeaker: "", answerSpeaker: "", index: 9999)
    var previousCard = Card(question: "", answer: "First line", section: "", categoryIndex: 0, questionSpeaker: "", answerSpeaker: "", index: 9999)
    var setName = ""
    var setType = ""
    var categories = NSMutableOrderedSet()
    var categoryArray = [CardCategory]()
    var cardIndex = 0
    var previousAnswer: String?
    
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
                let answer = dict["Line"] ?? ""
                var section = dict["Section"] ?? ""
                if section == "" {
                    section = self.previousCard.section
                }
                if section != self.previousCard.section {
                    self.previousCard = Card(question: "", answer: "First line", section: "", categoryIndex: 0, questionSpeaker: "", answerSpeaker: "", index: 9999)
                }
                switch self.setType {
                case "Script":
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
                        let card = Card(question: self.previousCard.answer, answer: answer, section: section, categoryIndex: categoryIndex, questionSpeaker: self.previousCard.answerSpeaker, answerSpeaker: dictCategory, index: self.cardIndex)
                        self.cardArray.append(card)
                        self.cardHolder = card
                    }
                    break
                case "Artist":
                    if dictCategory != "" {
                        if !self.categories.contains(dictCategory){
                            self.categories.add(dictCategory)
                            self.categoryArray.append(CardCategory(name: dictCategory))
                        }
                    }
                    let categoryIndex = self.categoryArray.count - 1
                    let whiteSpaceReducedAnswer = answer.replacingOccurrences(of: ": ", with: ":")
                    let tempAnswerArray = whiteSpaceReducedAnswer.components(separatedBy: ":")
                    if tempAnswerArray.count == 2 {
                        let card = Card(question: self.previousCard.answer, answer: tempAnswerArray[1], section: section, categoryIndex: categoryIndex, questionSpeaker: self.previousCard.answerSpeaker, answerSpeaker: tempAnswerArray[0], index: self.cardIndex)
                        self.cardArray.append(card)
                        self.cardHolder = card
                    } else {
                        let card = Card(question: self.previousCard.answer, answer: answer, section: section, categoryIndex: categoryIndex, questionSpeaker: self.previousCard.answerSpeaker, answerSpeaker: dictCategory, index: self.cardIndex)
                        self.cardArray.append(card)
                        self.cardHolder = card
                    }
                    break
                default:
                    break
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
                self.previousAnswer = nil
                let sectionObject = dataManager.generateSectionObject()
                categoryObject.addToSectionObjects(sectionObject)
                sectionObject.name = section.name
                for card in section.cards {
                    let cardObject = dataManager.generateCardObject()
                    sectionObject.addToCardObjects(cardObject)
                    cardObject.question = card.question
                    cardObject.answer = card.answer
                    cardObject.questionSpeaker = card.questionSpeaker
                    cardObject.answerSpeaker = card.answerSpeaker
                    cardObject.sameLine = false
                    if card.question == previousAnswer {
                        cardObject.sameLine = true
                    }
                    cardObject.index = Int16(card.index)
                    previousAnswer = cardObject.answer
                }
            }
        }
        dataManager.saveContext()
    }
}
