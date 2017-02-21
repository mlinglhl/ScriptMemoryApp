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

    func getFolders() -> [Folder]? {
        let context = getContext()
        let request: NSFetchRequest<NSFetchRequestResult> = Folder.fetchRequest()
        do {
            let folderArray = try context.fetch(request) as! [Folder]
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
    
    func generateFolder() -> Folder {
        let quoteObject = NSEntityDescription.insertNewObject(forEntityName: "Folder", into: self.getContext()) as! Folder
        return quoteObject
    }
    
    func generateDivision() -> Division {
        let division = NSEntityDescription.insertNewObject(forEntityName: "Division", into: self.getContext()) as! Division
        return division
    }

    func generateCard() -> Card {
        let card = NSEntityDescription.insertNewObject(forEntityName: "Card", into: self.getContext()) as! Card
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
