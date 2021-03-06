//
//  DataManager.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-20.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    static let sharedInstance = DataManager()
    private override init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Final_Demo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func getSetObjects() -> [SetObject] {
        let context = getContext()
        let request = NSFetchRequest<SetObject>(entityName: "SetObject")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        do {
            let folderArray = try context.fetch(request)
            return folderArray
        } catch {
            return [SetObject]()
        }
    }
    
// MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error \(nserror.localizedDescription)")
            }
        }
    }
    
    func generateSetObject() -> SetObject {
        let setObject = NSEntityDescription.insertNewObject(forEntityName: "SetObject", into: self.getContext()) as! SetObject
        return setObject
    }
    
    func generateCategoryObject() -> CategoryObject {
        let categoryObject = NSEntityDescription.insertNewObject(forEntityName: "CategoryObject", into: self.getContext()) as! CategoryObject
        return categoryObject
    }

    func generateSectionObject() -> SectionObject {
        let sectionObject = NSEntityDescription.insertNewObject(forEntityName: "SectionObject", into: self.getContext()) as! SectionObject
        return sectionObject
    }
    
    func generateCardObject() -> CardObject{
        let cardObject = NSEntityDescription.insertNewObject(forEntityName: "CardObject", into: self.getContext()) as! CardObject
        return cardObject
    }

    func deleteObject(_ managedObject: NSManagedObject) {
        let context = getContext()
        context.delete(managedObject)
        saveContext()
    }
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

}
