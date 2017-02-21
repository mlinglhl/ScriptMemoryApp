//
//  Division+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-20.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Division {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Division> {
        return NSFetchRequest<Division>(entityName: "Division");
    }

    @NSManaged public var name: String?
    @NSManaged public var cards: NSSet?
    @NSManaged public var folder: Folder?

}

// MARK: Generated accessors for cards
extension Division {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: Card)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: Card)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}
