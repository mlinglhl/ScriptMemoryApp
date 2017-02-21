//
//  Card+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-20.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card");
    }

    @NSManaged public var answer: String?
    @NSManaged public var audioQueue: NSData?
    @NSManaged public var part: String?
    @NSManaged public var question: String?
    @NSManaged public var score: Double
    @NSManaged public var division: Division?

}
