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
