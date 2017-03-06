//
//  SectionObject+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-05.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension SectionObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SectionObject> {
        return NSFetchRequest<SectionObject>(entityName: "SectionObject");
    }

    @NSManaged public var name: String?
    @NSManaged public var cardObjects: NSOrderedSet?
    @NSManaged public var categoryObject: CategoryObject?

}

// MARK: Generated accessors for cardObjects
extension SectionObject {

    @objc(insertObject:inCardObjectsAtIndex:)
    @NSManaged public func insertIntoCardObjects(_ value: CardObject, at idx: Int)

    @objc(removeObjectFromCardObjectsAtIndex:)
    @NSManaged public func removeFromCardObjects(at idx: Int)

    @objc(insertCardObjects:atIndexes:)
    @NSManaged public func insertIntoCardObjects(_ values: [CardObject], at indexes: NSIndexSet)

    @objc(removeCardObjectsAtIndexes:)
    @NSManaged public func removeFromCardObjects(at indexes: NSIndexSet)

    @objc(replaceObjectInCardObjectsAtIndex:withObject:)
    @NSManaged public func replaceCardObjects(at idx: Int, with value: CardObject)

    @objc(replaceCardObjectsAtIndexes:withCardObjects:)
    @NSManaged public func replaceCardObjects(at indexes: NSIndexSet, with values: [CardObject])

    @objc(addCardObjectsObject:)
    @NSManaged public func addToCardObjects(_ value: CardObject)

    @objc(removeCardObjectsObject:)
    @NSManaged public func removeFromCardObjects(_ value: CardObject)

    @objc(addCardObjects:)
    @NSManaged public func addToCardObjects(_ values: NSOrderedSet)

    @objc(removeCardObjects:)
    @NSManaged public func removeFromCardObjects(_ values: NSOrderedSet)

}
