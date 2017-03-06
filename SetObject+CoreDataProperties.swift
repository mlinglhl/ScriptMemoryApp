//
//  SetObject+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-05.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension SetObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SetObject> {
        return NSFetchRequest<SetObject>(entityName: "SetObject");
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var categoryObjects: NSOrderedSet?

}

// MARK: Generated accessors for categoryObjects
extension SetObject {

    @objc(insertObject:inCategoryObjectsAtIndex:)
    @NSManaged public func insertIntoCategoryObjects(_ value: CategoryObject, at idx: Int)

    @objc(removeObjectFromCategoryObjectsAtIndex:)
    @NSManaged public func removeFromCategoryObjects(at idx: Int)

    @objc(insertCategoryObjects:atIndexes:)
    @NSManaged public func insertIntoCategoryObjects(_ values: [CategoryObject], at indexes: NSIndexSet)

    @objc(removeCategoryObjectsAtIndexes:)
    @NSManaged public func removeFromCategoryObjects(at indexes: NSIndexSet)

    @objc(replaceObjectInCategoryObjectsAtIndex:withObject:)
    @NSManaged public func replaceCategoryObjects(at idx: Int, with value: CategoryObject)

    @objc(replaceCategoryObjectsAtIndexes:withCategoryObjects:)
    @NSManaged public func replaceCategoryObjects(at indexes: NSIndexSet, with values: [CategoryObject])

    @objc(addCategoryObjectsObject:)
    @NSManaged public func addToCategoryObjects(_ value: CategoryObject)

    @objc(removeCategoryObjectsObject:)
    @NSManaged public func removeFromCategoryObjects(_ value: CategoryObject)

    @objc(addCategoryObjects:)
    @NSManaged public func addToCategoryObjects(_ values: NSOrderedSet)

    @objc(removeCategoryObjects:)
    @NSManaged public func removeFromCategoryObjects(_ values: NSOrderedSet)

}
