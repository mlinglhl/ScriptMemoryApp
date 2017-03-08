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
    var setIndex = 0
    var categoryIndex = 0
    var sectionIndex = 0
    var typeIndex = 0
    var session = CardSession()
    var settings = SessionSettings()
    let dataManager = DataManager.sharedInstance

    
    static let sharedInstance = CardManager()
    private override init() {}
    
    func setUp() {
        setIndex = 0
        categoryIndex = 0
        sectionIndex = 0
        typeIndex = 0
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

//MARK: Setup extension
extension CardManager {
    struct SessionSettings {
        var randomMode = true
        var weakCardsMoreFrequentMode = true
        var failedCardsAtEndMode = true
        var soundCueMode = false
    }
}

//MARK: Session extension

extension CardManager {
    struct CardSession {
        var cardIndex = 0
        var numberCorrect = 0
        var numberWrong = 0
        var cardRecord = [Int: (Int, Int)]()
        var deck = [CardObject]()
        var extraCardCount = 0
        var extraCards = [CardObject]()
    }
    
    func startSession() {
        session = CardSession()
        makeDeck()
    }
    
    func makeDeck() {
        resetDeck()
        let cards = getCardArray()
        if let cards = cards {
            var cardArray = cards
            if settings.randomMode {
                if settings.weakCardsMoreFrequentMode {
                    for card in cardArray {
                        if card.correct + card.wrong > 0 {
                            let score = Double(card.correct)/Double(card.correct + card.wrong)
                            if score < 0.8 {
                                cardArray.append(card)
                                self.session.extraCardCount += 1
                                self.session.extraCards.append(card)
                            }
                            if score < 0.6 {
                                cardArray.append(card)
                                self.session.extraCardCount += 1
                                self.session.extraCards.append(card)
                            }
                            if score < 0.4 {
                                cardArray.append(card)
                                self.session.extraCardCount += 1
                                self.session.extraCards.append(card)
                            }
                            if score < 0.2 {
                                cardArray.append(card)
                                self.session.extraCardCount += 1
                                self.session.extraCards.append(card)
                            }
                        }
                    }
                }
                let end = cardArray.count
                var tempArray = [CardObject]()
                for _ in 0..<end {
                    let randomNumber = Int(arc4random_uniform(UInt32(cardArray.count)))
                    tempArray.append(cardArray[randomNumber])
                    cardArray.remove(at: randomNumber)
                }
                cardArray = tempArray
            }
            session.deck = cardArray
        }
    }
    
    func markCard(_ index: Int, isCorrect: Bool) {
        if !session.cardRecord.keys.contains(index) {
            session.cardRecord.updateValue((0, 0), forKey: index)
        }
        var correctAmount = session.cardRecord[index]!.0
        var wrongAmount = session.cardRecord[index]!.1
        let cards = session.deck
        if isCorrect {
            correctAmount += 1
            session.cardRecord.updateValue((correctAmount, wrongAmount), forKey: index)
            cards[session.cardIndex].correct += 1
            dataManager.saveContext()
            return
        }
        wrongAmount += 1
        session.cardRecord.updateValue((correctAmount, wrongAmount), forKey: index)
        cards[session.cardIndex].wrong += 1
        if settings.failedCardsAtEndMode {
            session.deck.append(cards[session.cardIndex])
            session.extraCardCount += 1
        }
        dataManager.saveContext()
    }
    
    func setUpCardFrontWithModifiedDeck(_ cardView: CardView) {
        let card = session.deck[session.cardIndex]
        cardView.questionSpeakerLabel.text = card.questionSpeaker ?? "No text"
        cardView.questionLabel.text = card.question ?? "No text"
        cardView.answerSpeakerLabel.text = card.answerSpeaker ?? "No text"
        cardView.answerLabel.text = card.answer ?? "No text"
    }
    
    func setUpCardFrontWithUnmodifiedDeck(_ cardView: CardView) {
        let cards = getCardArray()
        guard let currentCards = cards else {
            return
        }
        let card = currentCards[session.cardIndex]
        cardView.questionSpeakerLabel.text = card.questionSpeaker ?? "No text"
        cardView.questionLabel.text = card.question ?? "No text"
        cardView.answerSpeakerLabel.text = card.answerSpeaker ?? "No text"
        cardView.answerLabel.text = card.answer ?? "No text"
    }
    
    func getCurrentCard() -> CardObject? {
        return session.deck[session.cardIndex]
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
        if cards.count < 1 {
            print ("No cards found")
            return nil
        }
        return cards
    }
    
    func resetDeck() {
        session.cardIndex = 0
        trimExtraCards()
        session.extraCards.removeAll()
        session.extraCardCount = 0
    }
    
    func getSessionResults() -> [Int] {
        return (session.cardRecord.keys).sorted()
    }
    
    func checkLast() -> Bool {
        let cards = session.deck
        if session.cardIndex == cards.count - 1 {
            return true
        }
        return false
    }
    
    func nextCardSameLine() -> Bool {
        let cards = session.deck
        let card = cards[session.cardIndex]
        return card.sameLine
    }
    
    func trimExtraCards() {
        if session.extraCardCount > 0 {
            for _ in 0..<session.extraCardCount {
                session.extraCards.append(session.deck.last!)
                session.deck.removeLast()
            }
        }
    }
    
    func restoreExtraCards() {
        if session.extraCardCount > 0 {
            for _ in 0..<session.extraCardCount {
                session.deck.append(session.extraCards.first!)
                session.extraCards.removeFirst()
            }
        }
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
            var sectionName = section.name ?? ""
            if sectionName.characters.count > 23 {
                sectionName = sectionName.substring(to: sectionName.index(sectionName.startIndex, offsetBy: 20))
                sectionName.append("...")
            }
            nameArray.append("\(sectionName)")
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

