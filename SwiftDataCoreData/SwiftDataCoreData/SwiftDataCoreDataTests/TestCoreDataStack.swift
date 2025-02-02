//
//  TestCoreDataStack.swift
//  SwiftDataCoreDataTests
//
//  Created by Vitor Costa on 14/07/24.
//

import CoreData
@testable import SwiftDataCoreData

class TestCoreDataStack: CoreDataStack {
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(
            name: dbName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { ( _, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer = container
    }
}

