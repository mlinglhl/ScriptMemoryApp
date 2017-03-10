//
//  CardObject+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-10.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension CardObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardObject> {
        return NSFetchRequest<CardObject>(entityName: "CardObject");
    }

    @NSManaged public var answer: String?
    @NSManaged public var answerAudio: NSData?
    @NSManaged public var answerSpeaker: String?
    @NSManaged public var correct: Int16
    @NSManaged public var index: Int16
    @NSManaged public var part: String?
    @NSManaged public var question: String?
    @NSManaged public var questionAudio: NSData?
    @NSManaged public var questionSpeaker: String?
    @NSManaged public var sameLine: Bool
    @NSManaged public var wrong: Int16
    @NSManaged public var sectionObject: SectionObject?

}
