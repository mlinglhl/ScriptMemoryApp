//
//  CategoryObject+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-22.
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
    @NSManaged public var order: Int16
    @NSManaged public var cardObjects: NSSet?
    @NSManaged public var setObject: SetObject?

}

// MARK: Generated accessors for cardObjects
extension CategoryObject {

    @objc(addCardObjectsObject:)
    @NSManaged public func addToCardObjects(_ value: CardObject)

    @objc(removeCardObjectsObject:)
    @NSManaged public func removeFromCardObjects(_ value: CardObject)

    @objc(addCardObjects:)
    @NSManaged public func addToCardObjects(_ values: NSSet)

    @objc(removeCardObjects:)
    @NSManaged public func removeFromCardObjects(_ values: NSSet)

}
