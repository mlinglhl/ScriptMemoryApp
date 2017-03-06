//
//  CategoryObject+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-05.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension CategoryObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryObject> {
        return NSFetchRequest<CategoryObject>(entityName: "CategoryObject");
    }

    @NSManaged public var name: String?
    @NSManaged public var sectionObjects: NSOrderedSet?
    @NSManaged public var setObject: SetObject?

}

// MARK: Generated accessors for sectionObjects
extension CategoryObject {

    @objc(insertObject:inSectionObjectsAtIndex:)
    @NSManaged public func insertIntoSectionObjects(_ value: SectionObject, at idx: Int)

    @objc(removeObjectFromSectionObjectsAtIndex:)
    @NSManaged public func removeFromSectionObjects(at idx: Int)

    @objc(insertSectionObjects:atIndexes:)
    @NSManaged public func insertIntoSectionObjects(_ values: [SectionObject], at indexes: NSIndexSet)

    @objc(removeSectionObjectsAtIndexes:)
    @NSManaged public func removeFromSectionObjects(at indexes: NSIndexSet)

    @objc(replaceObjectInSectionObjectsAtIndex:withObject:)
    @NSManaged public func replaceSectionObjects(at idx: Int, with value: SectionObject)

    @objc(replaceSectionObjectsAtIndexes:withSectionObjects:)
    @NSManaged public func replaceSectionObjects(at indexes: NSIndexSet, with values: [SectionObject])

    @objc(addSectionObjectsObject:)
    @NSManaged public func addToSectionObjects(_ value: SectionObject)

    @objc(removeSectionObjectsObject:)
    @NSManaged public func removeFromSectionObjects(_ value: SectionObject)

    @objc(addSectionObjects:)
    @NSManaged public func addToSectionObjects(_ values: NSOrderedSet)

    @objc(removeSectionObjects:)
    @NSManaged public func removeFromSectionObjects(_ values: NSOrderedSet)

}
