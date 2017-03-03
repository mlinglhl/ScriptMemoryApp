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
    
    func randomNumber(_ ceiling: Int) -> Int {
        return Int(arc4random_uniform(UInt32(ceiling)))
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
                return
            }
        }
        wrongAmount += 1
        session.cardRecord.updateValue((correctAmount, wrongAmount), forKey: index)
        if let cards = cards {
            cards[index].wrong += 1
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
    
    func getCardArray() -> [CardObject]? {
        if activeArray.count < setIndex + 1 {
            print ("No sets found")
            return nil
        }
        let categories = activeArray[setIndex].categoryObjectsArray()
        if categories.count < categoryIndex + 1 {
            print ("No categories found")
            return nil
        }
        let sections = categories[categoryIndex].sectionObjectsArray()
        if sections.count < sectionIndex + 1 {
            print ("No sections found")
            return nil
        }
        let cards = sections[sectionIndex].cardObjectsArray()
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
    func getCategoryDataAtIndex(_ index: Int) -> [Double] {
        //generate data from setArray.categories[index]
        let data: [Double] = [12/17*100, 23/25*100, 13/16*100, 24/36*100, 13/14*100, 12/100*100]
        let data2: [Double] = [7/17*100, 21/25*100, 14/16*100, 33/36*100, 2/14*100, 88/100*100]
        let data3: [Double] = [15/17*100, 17/25*100, 8/16*100, 12/36*100, 10/14*100, 85/100*100]
        let data4: [Double] = [14/17*100, 20/25*100, 16/16*100, 35/36*100, 12/14*100, 95/100*100]
        let data5: [Double] = [10/17*100, 12/25*100, 11/16*100, 21/36*100, 5/14*100, 65/100*100]
        let data6: [Double] = [17/17*100, 22/25*100, 12/16*100, 11/36*100, 14/14*100, 95/100*100]
        let dataArray = [data, data2, data3, data4, data5, data6]
        let selector = randomNumber(6)
        return dataArray[Int(selector)]
    }
    
    func getSectionDataAtIndex(_ index: Int) -> [Double] {
        //generate data from setArray.categories[categoryIndex].cards[index]
        let data: [Double] = [12/17*100, 23/25*100, 13/16*100, 24/36*100, 13/14*100, 12/100*100]
        let data2: [Double] = [7/17*100, 21/25*100, 14/16*100, 33/36*100, 2/14*100, 88/100*100]
        let data3: [Double] = [15/17*100, 17/25*100, 8/16*100, 12/36*100, 10/14*100, 85/100*100]
        let data4: [Double] = [14/17*100, 20/25*100, 16/16*100, 35/36*100, 12/14*100, 95/100*100]
        let data5: [Double] = [10/17*100, 12/25*100, 11/16*100, 21/36*100, 5/14*100, 65/100*100]
        let data6: [Double] = [17/17*100, 22/25*100, 12/16*100, 11/36*100, 14/14*100, 95/100*100]
        let dataArray = [data, data2, data3, data4, data5, data6]
        let selector = randomNumber(6)
        return dataArray[Int(selector)]
    }
    
    func getCardLabels() -> [String] {
        var nameArray = [String]()
        for card in sampleActiveArray[setIndex].categories[categoryIndex].cards {
            nameArray.append("\(card.number)")
        }
        return nameArray
    }
}

