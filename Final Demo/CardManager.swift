//
//  CardManager.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-20.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class CardManager: NSObject {
    var setArray = [SetObject]()
    var scriptArray = [SetObject]()
    var artistArray = [SetObject]()
    var activeArray = [SetObject]()
    var sampleActiveArray = [SampleScript]()
    var sampleScriptArray = [SampleScript]()
    var sampleArtistArray = [SampleScript]()
    var sampleCharacter: SampleCharacter?
    var setIndex = 0
    var categoryIndex = 0
    var sectionIndex = 0
    var typeIndex = 0
    var session = CardSession(setName: "Default", categoryName: "Default")
    let dataManager = DataManager.sharedInstance
    
    static let sharedInstance = CardManager()
    private override init() {}
    
    func setUp() {
        setArray = dataManager.getSetObjects()
        scriptArray = setUpSetArray(type: "Script")
        artistArray = setUpSetArray(type: "Artist")
        activeArray = scriptArray
    }
    
    func setUpSetArray(type: String) -> [SetObject] {
        var tempArray = [SetObject]()
        for set in setArray {
            if set.type == type {
                tempArray.append(set)
            }
        }
        return tempArray
    }
    
    func changeType(_ index: Int) {
        switch index {
        case 0:
            if activeArray.description != scriptArray.description {
                activeArray = scriptArray
                typeIndex = 0
                setIndex = 0
                categoryIndex = 0
            }
            break
        case 1:
            if activeArray.description != artistArray.description {
                activeArray = artistArray
                typeIndex = 1
                setIndex = 0
                categoryIndex = 0
            }
            break
        default:
            break
        }
    }
    
    func createCardWith(set: String, category: String, question: String, questionSpeaker: String, answer: String, type: Int) {
        //        let cardSet = getSetWithName(set)
        //        let cardCategory = getCategoryWithName(category, set: cardSet)
        //        let cardSection = getSectionWithName(
        //        let newCard = DataManager.sharedInstance.generateCard()
        //        newCard.sectionObject = cardCategory
        //        newCard.question = "\(questionSpeaker): \(question)"
        //        newCard.answer = "\(answer)"
        //        if type == 1 {
        //            newCard.answer = "\(category): \(answer)"
        //        }
        //        DataManager.sharedInstance.saveContext()
    }
    
    func getSetWithName(_ name: String) -> SetObject{
        for setObject in setArray {
            if setObject.name == name {
                return setObject
            }
        }
        let newObject = DataManager.sharedInstance.generateSetObject()
        newObject.name = name
        setArray.append(newObject)
        return newObject
    }
    
    func getCategoryWithName(_ name: String, set: SetObject) -> CategoryObject {
        if let categories = set.categoryObjects {
            for categoryObject in categories {
                if (categoryObject as AnyObject).name == name {
                    return categoryObject as! CategoryObject
                }
            }
        }
        let categoryObject = DataManager.sharedInstance.generateCategoryObject()
        categoryObject.name = name
        set.addToCategoryObjects(categoryObject)
        return categoryObject
    }
}

//MARK: Session extension

extension CardManager {
    struct CardSession {
        var setName: String!
        var categoryName: String!
        var cardIndex = 0
        var numberCorrect = 0
        var numberWrong = 0
        var isDone = false
        var cardRecord = [Int: (Int, Int)]()
        var sessionIndex = 0
        
        init(setName: String, categoryName: String) {
            self.setName = setName
            self.categoryName = categoryName
        }
    }
    
    func startSession() {
        let setName = activeArray[setIndex].name!
        let category = activeArray[setIndex].categoryObjects?.object(at: categoryIndex) as! CategoryObject
        session = CardSession(setName: setName, categoryName: category.name!)
    }
    
    func markCard(_ index: Int, isCorrect: Bool) {
        if !session.cardRecord.keys.contains(index) {
            session.cardRecord.updateValue((0, 0), forKey: index)
        }
        var correctAmount = session.cardRecord[index]!.0
        var wrongAmount = session.cardRecord[index]!.1
        let cards = getCardArray()
        if isCorrect {
            correctAmount += 1
            session.cardRecord.updateValue((correctAmount, wrongAmount), forKey: index)
            if let cards = cards {
                cards[index].correct += 1
                dataManager.saveContext()
                return
            }
        }
        wrongAmount += 1
        session.cardRecord.updateValue((correctAmount, wrongAmount), forKey: index)
        if let cards = cards {
            cards[index].wrong += 1
            dataManager.saveContext()
            return
        }
        print("Could not reach card")
        return
    }
    
    func setCardQuestion() -> String {
        let card = getCurrentCard()
        if let card = card {
            return card.question ?? "No text"
        }
        return "No text"
    }
    
    func setCardAnswer() -> String {
        let card = getCurrentCard()
        if let card = card {
            return card.answer ?? "No text"
        }
        return "No text"
    }
    
    func getCurrentCard() -> CardObject? {
        let cards = getCardArray()
        return cards?[session.cardIndex]
    }
    
    func getScore() -> String {
        var correct = 0
        var wrong = 0
        for index in session.cardRecord {
            correct += index.value.0
            wrong += index.value.1
        }
        if correct + wrong > 0 {
            let score = correct * 100 / (correct + wrong)
            return "Score: \(score)%"
        }
        return "Score: No cards marked"
    }
    
    func getSetArray() -> [SetObject]? {
        if activeArray.count < setIndex + 1 {
            print ("No sets found")
            return nil
        }
        return activeArray
    }
    
    func getCategoryArray() -> [CategoryObject]? {
        let sets = getSetArray()
        guard let currentSets = sets else {
            print("No sets found")
            return nil
        }
        let categories = currentSets[setIndex].categoryObjectsArray()
        if categories.count < categoryIndex + 1 {
            print ("No categories found")
            return nil
        }
        return categories
    }
    
    func getSectionArray() -> [SectionObject]? {
        let categories = getCategoryArray()
        guard let currentCategories = categories else {
            print("No categories found")
            return nil
        }
        let sections = currentCategories[categoryIndex].sectionObjectsArray()
        if sections.count < sectionIndex + 1 {
            print ("No sections found")
            return nil
        }
        return sections
    }
    
    func getCardArray() -> [CardObject]? {
        let sections = getSectionArray()
        guard let currentSections = sections else {
            print ("No sections found")
            return nil
        }
        let cards = currentSections[sectionIndex].cardObjectsArray()
        if cards.count < session.cardIndex + 1 {
            print ("No cards found")
            return nil
        }
        return cards
    }
    
    func resetDeck() {
        session.cardIndex = 0
        session.sessionIndex += 1
    }
    
    func getSessionResults() -> [Int] {
        return (session.cardRecord.keys).sorted()
    }
    
    func checkLast() -> Bool {
        session.cardIndex += 1
        if activeArray.count < setIndex + 1 {
            print ("No sets found")
            return true
        }
        let categories = activeArray[setIndex].categoryObjectsArray()
        if categories.count < categoryIndex + 1 {
            print ("No categories found")
            return true
        }
        let sections = categories[categoryIndex].sectionObjectsArray()
        if sections.count < sectionIndex + 1 {
            print ("No sections found")
            return true
        }
        let cards = sections[sectionIndex].cardObjectsArray()
        if session.cardIndex == cards.count {
            return true
        }
        return false
    }
    
}

//MARK: Statistics Extension

extension CardManager {
    
    func getDataForSelectedTableViewSection(_ index: Int) -> [Double] {
        switch index {
        case 0:
            return getDataForSelectedSet()
        case 1:
            return getDataForSelectedCategory()
        case 2:
            return getDataForSelectedSection()
        default:
            return [Double]()
        }
    }
    
    func getLabelsForSelectedTableViewSection(_ index: Int) -> [String] {
        switch index {
        case 0:
            return getLabelsForSelectedSet()
        case 1:
            return getLabelsForSelectedCategory()
        case 2:
            return getLabelsForSelectedSection()
        default:
            return [String]()
        }
    }
    
    func getDataForSelectedSection() -> [Double] {
        var statsArray = [Double]()
        let cards = getCardArray()
        guard let currentCards = cards else {
            return [Double]()
        }
        for card in currentCards {
            if card.correct + card.wrong < 1 {
                statsArray.append(Double(0))
                continue
            }
            let cardCorrect = Double(card.correct)
            let cardWrong = Double(card.wrong)
            statsArray.append(cardCorrect/(cardCorrect + cardWrong)*100)
        }
        return statsArray
    }
    
    func getLabelsForSelectedSection() -> [String] {
        var nameArray = [String]()
        let cards = getCardArray()
        guard let currentCards = cards else {
            return [String]()
        }
        for index in 0..<currentCards.count {
            nameArray.append("\(index)")
        }
        return nameArray
    }
    
    func getDataForSelectedCategory() -> [Double] {
        var statsArray = [Double]()
        let sections = getSectionArray()
        guard let currentSections = sections else {
            return [Double]()
        }
        for section in currentSections {
            var correct = 0
            var wrong = 0
            let cards = section.cardObjectsArray()
            for card in cards {
                correct += Int(card.correct)
                wrong += Int(card.wrong)
            }
            if correct + wrong < 1 {
                statsArray.append(Double(0))
                continue
            }
            let cardCorrect = Double(correct)
            let cardWrong = Double(wrong)

            statsArray.append(Double(cardCorrect/(cardCorrect + cardWrong)*100))
        }
        return statsArray
    }
    
    func getLabelsForSelectedCategory() -> [String] {
        var nameArray = [String]()
        let sections = getSectionArray()
        guard let currentSections = sections else {
            return [String]()
        }
        for section in currentSections {
            nameArray.append("\(section.name)")
        }
        return nameArray
    }
    
    func getDataForSelectedSet() -> [Double] {
        var statsArray = [Double]()
        let categories = getCategoryArray()
        guard let currentCategories = categories else {
            return [Double]()
        }
        for category in currentCategories {
            var correct = 0
            var wrong = 0
            let sections = category.sectionObjectsArray()
            for section in sections {
                let cards = section.cardObjectsArray()
                for card in cards {
                    correct += Int(card.correct)
                    wrong += Int(card.wrong)
                }
            }
            if correct + wrong < 1 {
                statsArray.append(Double(0))
                continue
            }
            let cardCorrect = Double(correct)
            let cardWrong = Double(wrong)
            
            statsArray.append(Double(cardCorrect/(cardCorrect + cardWrong)*100))
        }
        return statsArray
    }
    
    func getLabelsForSelectedSet() -> [String] {
        var nameArray = [String]()
        let categories = getCategoryArray()
        guard let currentCategories = categories else {
            return [String]()
        }
        for category in currentCategories {
            nameArray.append(category.name ?? "")
        }
        return nameArray
    }
}

