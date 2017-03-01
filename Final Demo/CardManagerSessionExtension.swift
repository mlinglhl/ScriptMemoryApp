//
//  CardManagerSessionExtension.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-27.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

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
        if isCorrect {
            correctAmount += 1
            session.cardRecord.updateValue((correctAmount, wrongAmount), forKey: index)
            //mark cardObject +1 correct
            return
        }
        //mark cardObject +1 wrong
        wrongAmount += 1
        session.cardRecord.updateValue((correctAmount, wrongAmount), forKey: index)
        return
    }
    
    func getCurrentCard() -> CardObject? {
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
        return cards[session.cardIndex]
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
