//
//  CategoryObject+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-28.
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
    @NSManaged public var setObject: SetObject?
    @NSManaged public var sectionObjects: NSSet?

}

// MARK: Generated accessors for sectionObjects
extension CategoryObject {

    @objc(addSectionObjectsObject:)
    @NSManaged public func addToSectionObjects(_ value: SectionObject)

    @objc(removeSectionObjectsObject:)
    @NSManaged public func removeFromSectionObjects(_ value: SectionObject)

    @objc(addSectionObjects:)
    @NSManaged public func addToSectionObjects(_ values: NSSet)

    @objc(removeSectionObjects:)
    @NSManaged public func removeFromSectionObjects(_ values: NSSet)

}
