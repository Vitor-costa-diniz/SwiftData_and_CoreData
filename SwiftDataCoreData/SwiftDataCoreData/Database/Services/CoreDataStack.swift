//
//  CoreDataStack.swift
//  SwiftDataCoreData
//
//  Created by Vitor Costa on 11/07/24.
//

import Foundation
import CoreData

let dbName = "UserCoreData"

class CoreDataStack {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataStack()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: dbName)
        persistentContainer.loadPersistentStores {(_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func saveContext() {
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
}
