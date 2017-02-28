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
        var cardRecord = [Int: Bool]()
        
        init(setName: String, categoryName: String) {
            self.setName = setName
            self.categoryName = categoryName
        }
    }
    
    func startSession() {
        session = CardSession(setName: sampleScriptArray[setIndex].name, categoryName: sampleScriptArray[categoryIndex].name)
    }
    
    func markCard(_ index: Int, isCorrect: Bool) {
        session.cardRecord.updateValue(isCorrect, forKey: index)
        if isCorrect {
            //mark cardObject +1 correct
        return
        }
        //mark cardObject +1 wrong
        return
    }
    
    func setCardQuestion() -> String {
        let question = sampleActiveArray[setIndex].categories[categoryIndex].cards[session.cardIndex].question
        return question
    }
    
    func setCardAnswer() -> String {
        let answer = sampleActiveArray[setIndex].categories[categoryIndex].cards[session.cardIndex].answer
        session.cardIndex += 1
        return answer
    }
    
    func getScore() -> String {
        var correct = 0
        var wrong = 0
        for (_, isCorrect) in session.cardRecord {
            if isCorrect {
                correct += 1
                continue
            }
            wrong += 1
        }
        if correct + wrong > 0 {
            let score = correct * 100 / (correct + wrong)
            return "Score: \(score)%"
        }
        return "Score: No cards marked"
    }
}
