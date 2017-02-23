//
//  SetObject+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-23.
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
    @NSManaged public var categoryObjects: NSSet?

}

// MARK: Generated accessors for categoryObjects
extension SetObject {

    @objc(addCategoryObjectsObject:)
    @NSManaged public func addToCategoryObjects(_ value: CategoryObject)

    @objc(removeCategoryObjectsObject:)
    @NSManaged public func removeFromCategoryObjects(_ value: CategoryObject)

    @objc(addCategoryObjects:)
    @NSManaged public func addToCategoryObjects(_ values: NSSet)

    @objc(removeCategoryObjects:)
    @NSManaged public func removeFromCategoryObjects(_ values: NSSet)

}
