//
//  CoreDataExtensions.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-03-01.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

extension SetObject {
    func categoryObjectsArray() -> [CategoryObject] {
        let ordered = self.categoryObjects
        let anyArray = ordered?.array
        if let castCategory = anyArray as? [CategoryObject] {
            return castCategory
        }
        return [CategoryObject]()
    }
}

extension CategoryObject {
    func sectionObjectsArray() -> [SectionObject] {
        let ordered = self.sectionObjects
        let anyArray = ordered?.array
        if let castSection = anyArray as? [SectionObject] {
            return castSection
        }
        return [SectionObject]()
    }
}

extension SectionObject {
    func cardObjectsArray() -> [CardObject] {
        let ordered = self.cardObjects
        let anyArray = ordered?.array
        if let castCategory = anyArray as? [CardObject] {
            return castCategory
        }
        return [CardObject]()
    }
}
