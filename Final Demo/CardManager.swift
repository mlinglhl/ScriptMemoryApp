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
    var cardIndex = 0
    var cardArray = [SampleCard.init(question: "Annabel: I have come all this way for the money Mr. Witherspoon. All six million dollars of it.", answer: "Harry: But I accepted the terms of my Uncle's will, and I'm here, you see, carrying out his wishes. So you people have lost."),
                     SampleCard.init(question: "Annabel: Not yet we haven't. Not by a longshot. You see, there's a loophole.", answer: "Harry: Loophole? What loophole? Where?"),
                     SampleCard.init(question: "Annabel: Well, when we received our copy of the will and tape, I noticed how detailed it was. All those social activities. All the things he wants to do and buy and wear... specific times you have to be specific places...", answer: "Harry: I'm doing the best I can!"),
                     SampleCard.init(question: "Annabel: Yes, but make just one little slip--arrive somewhere one minute early or one minute late, put a pink flower in his buttonhole instead of red... you mess up one little detail, and accoridng to our lawyers, you'll be in default of the will!", answer: "Harry: What?!"),
                     SampleCard.init(question: "Annabel: One little slip, and I take your Uncle, finish up the rest of his vacation, and that money goes to the dogs! So you might as well give up!", answer: "Harry: Give up? Give up! You're joking!")]
    
    static let sharedInstance = CardManager()
    private override init() {}
    
    func setUp() {
        guard let folders = DataManager.sharedInstance.getSetObjects() else {
            return
        }
        setArray = folders
        scriptArray = setUpFolderArray(type: "Script")
        artistArray = setUpFolderArray(type: "Artist")
        activeArray = scriptArray
    }
    
    func setUpFolderArray(type: String) -> [SetObject] {
        var tempArray = [SetObject]()
        for set in setArray {
            if set.type == type {
                tempArray.append(set)
            }
        }
        return tempArray
    }
    
    func setCardQuestion() -> String {
        return cardArray[cardIndex].question
    }
    
    func setCardAnswer() -> String {
        let answer = cardArray[cardIndex].answer
        cardIndex += 1
        if cardIndex == cardArray.count {
            cardIndex = 0
        }
        return answer
    }
    
    func createCardWith(set: String, category: String, question: String, questionSpeaker: String, answer: String, type: String) {
        let cardSet = getSetWithName(set)
        let cardCategory = getCategoryWithName(category, set: cardSet)
        let newCard = DataManager.sharedInstance.generateCard()
        newCard.categoryObject = cardCategory
        newCard.question = "\(questionSpeaker): \(question)"
        newCard.answer = "\(answer)"
        if type == "Artist" {
            newCard.answer = "\(category): \(answer)"
        }
        DataManager.sharedInstance.saveContext()
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
