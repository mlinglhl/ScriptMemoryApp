//
//  Folder+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-20.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder");
    }

    @NSManaged public var writer: String?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var divisions: NSSet?

}

// MARK: Generated accessors for divisions
extension Folder {

    @objc(addDivisionsObject:)
    @NSManaged public func addToDivisions(_ value: Division)

    @objc(removeDivisionsObject:)
    @NSManaged public func removeFromDivisions(_ value: Division)

    @objc(addDivisions:)
    @NSManaged public func addToDivisions(_ values: NSSet)

    @objc(removeDivisions:)
    @NSManaged public func removeFromDivisions(_ values: NSSet)

}
