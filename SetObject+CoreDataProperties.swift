//
//  SetObject+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-22.
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
    @NSManaged public var writer: String?
    @NSManaged public var categorieObjectss: NSSet?

}

// MARK: Generated accessors for categorieObjectss
extension SetObject {

    @objc(addCategorieObjectssObject:)
    @NSManaged public func addToCategorieObjectss(_ value: CategoryObject)

    @objc(removeCategorieObjectssObject:)
    @NSManaged public func removeFromCategorieObjectss(_ value: CategoryObject)

    @objc(addCategorieObjectss:)
    @NSManaged public func addToCategorieObjectss(_ values: NSSet)

    @objc(removeCategorieObjectss:)
    @NSManaged public func removeFromCategorieObjectss(_ values: NSSet)

}
