//
//  SectionObject+CoreDataProperties.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-28.
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
    @NSManaged public var categoryObject: CategoryObject?
    @NSManaged public var cardObjects: CardObject?

}
