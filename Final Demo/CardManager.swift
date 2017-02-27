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
    var cardIndex = 0
    var typeIndex = 0
    
    static let sharedInstance = CardManager()
    private override init() {}
    
    func setUp() {
        let taylorSwift = SampleScript("Taylor Swift")
        sampleArtistArray.append(taylorSwift)
        taylorSwift.categories.append(SampleCharacter("Speak Now", script: taylorSwift))
        taylorSwift.categories.append(SampleCharacter("Mine", script: taylorSwift))
        taylorSwift.categories.append(SampleCharacter("22", script: taylorSwift))
        let amaranthe = SampleScript("Amaranthe")
        sampleArtistArray.append(amaranthe)
        amaranthe.categories.append(SampleCharacter("Amaranthine", script: amaranthe))
        amaranthe.categories.append(SampleCharacter("Hunger", script: amaranthe))
        amaranthe.categories.append(SampleCharacter("Burn With Me", script: amaranthe))
        let legallyBlonde = SampleScript("Legally Blonde")
        sampleScriptArray.append(legallyBlonde)
        sampleActiveArray = sampleScriptArray
        legallyBlonde.categories.append(SampleCharacter("Elle Woods", script: legallyBlonde))
        legallyBlonde.categories.append(SampleCharacter("Emmet Forest", script: legallyBlonde))
        legallyBlonde.categories.append(SampleCharacter("Kyle", script: legallyBlonde))
        let luckyStiff = SampleScript("Lucky Stiff")
        sampleScriptArray.append(luckyStiff)
        sampleActiveArray = sampleScriptArray
        let harry = SampleCharacter("Harry Witherspoon", script: luckyStiff)
        luckyStiff.categories.append(harry)
        luckyStiff.categories.append(SampleCharacter("Annabel Glick", script: luckyStiff))
        luckyStiff.categories.append(SampleCharacter("Anthony Hendon", script: luckyStiff))
        
        let card1 = SampleCard.init(question: "Annabel: I have come all this way for the money Mr. Witherspoon. All six million dollars of it.", answer: "Harry: But I accepted the terms of my Uncle's will, and I'm here, you see, carrying out his wishes. So you people have lost.", character: harry)
        let card2 = SampleCard(question: "Annabel: Not yet we haven't. Not by a longshot. You see, there's a loophole.", answer: "Harry: Loophole? What loophole? Where?", character: harry)
        let card3 = SampleCard(question: "Annabel: Well, when we received our copy of the will and tape, I noticed how detailed it was. All those social activities. All the things he wants to do and buy and wear... specific times you have to be specific places...", answer: "Harry: I'm doing the best I can!", character: harry)
        let card4 = SampleCard(question: "Annabel: Yes, but make just one little slip--arrive somewhere one minute early or one minute late, put a pink flower in his buttonhole instead of red... you mess up one little detail, and accoridng to our lawyers, you'll be in default of the will!", answer: "Harry: What?!", character: harry)
        let card5 = SampleCard(question: "Annabel: One little slip, and I take your Uncle, finish up the rest of his vacation, and that money goes to the dogs! So you might as well give up!", answer: "Harry: Give up? Give up! You're joking!", character: harry)
        harry.cards.append(card1)
        harry.cards.append(card2)
        harry.cards.append(card3)
        harry.cards.append(card4)
        harry.cards.append(card5)
        guard let folders = DataManager.sharedInstance.getSetObjects() else {
            return
        }
        setArray = folders
        scriptArray = setUpFolderArray(type: "Script")
        artistArray = setUpFolderArray(type: "Artist")
        activeArray = scriptArray
        sampleCharacter = sampleScriptArray[0].categories[0]
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
    
    func changeType(_ index: Int) {
        switch index {
        case 0:
            if sampleActiveArray.description != sampleScriptArray.description {
                sampleActiveArray = sampleScriptArray
                typeIndex = 0
                setIndex = 0
                categoryIndex = 0
            }
            break
        case 1:
            if sampleActiveArray.description != sampleArtistArray.description {
                sampleActiveArray = sampleArtistArray
                typeIndex = 1
                setIndex = 0
                categoryIndex = 0
            }
            break
        default:
            break
        }
    }
    
    func setCardQuestion() -> String {
        if let sampleCharacter = sampleCharacter {
            return sampleCharacter.cards[cardIndex].question
        }
        return "Default question"
    }
    
    func setCardAnswer() -> String {
        if let sampleCharacter = sampleCharacter {
            let answer = sampleCharacter.cards[cardIndex].answer
            return answer
        }
        return "Default answer"
    }
    
    func createCardWith(set: String, category: String, question: String, questionSpeaker: String, answer: String, type: Int) {
        let cardSet = getSetWithName(set)
        let cardCategory = getCategoryWithName(category, set: cardSet)
        let newCard = DataManager.sharedInstance.generateCard()
        newCard.categoryObject = cardCategory
        newCard.question = "\(questionSpeaker): \(question)"
        newCard.answer = "\(answer)"
        if type == 1 {
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
