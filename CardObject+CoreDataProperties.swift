//
//  CardObject+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-01.
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
    @NSManaged public var audioQueue: NSData?
    @NSManaged public var multiPerson: Bool
    @NSManaged public var order: Int16
    @NSManaged public var part: String?
    @NSManaged public var question: String?
    @NSManaged public var right: Int16
    @NSManaged public var wrong: Int16
    @NSManaged public var sectionObject: SectionObject?

}
