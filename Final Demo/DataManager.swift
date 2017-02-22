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

    func getSetObjects() -> [SetObject]? {
        let context = getContext()
        let request: NSFetchRequest<NSFetchRequestResult> = SetObject.fetchRequest()
        do {
            let folderArray = try context.fetch(request) as! [SetObject]
            return folderArray
        } catch {
            print("Failed to get results")
            return nil
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
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func generateSetObject() -> SetObject {
        let quoteObject = NSEntityDescription.insertNewObject(forEntityName: "SetObject", into: self.getContext()) as! SetObject
        return quoteObject
    }
    
    func generateCategoryObject() -> CategoryObject {
        let division = NSEntityDescription.insertNewObject(forEntityName: "CategoryObject", into: self.getContext()) as! CategoryObject
        return division
    }

    func generateCard() -> CardObject{
        let card = NSEntityDescription.insertNewObject(forEntityName: "CardObject", into: self.getContext()) as! CardObject
        return card
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
