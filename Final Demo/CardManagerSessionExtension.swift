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
    
    func getCurrentCard() -> CardObject {
        let set = activeArray[setIndex]
        let category = set.categoryObjects?.object(at: categoryIndex) as! CategoryObject
        let section = category.sectionObjects?.object(at: 0) as! SectionObject
        let card = section.cardObjects?.object(at: session.cardIndex) as! CardObject
        return card
    }
    
    func setCardQuestion() -> String {
        let card = getCurrentCard()
        return card.question!
    }
    
    func setCardAnswer() -> String {
        let card = getCurrentCard()
        return card.answer!
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
        if session.cardIndex == sampleActiveArray[setIndex].categories[categoryIndex].cards.count {
            return true
        }
        return false
    }
    
}
