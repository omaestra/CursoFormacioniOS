//
//  CoreDataManager.swift
//  RecipesCoreDataSample
//
//  Created by omaestra on 03/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
//    var managedObjectContext: NSManagedObjectContext
//    
//    init(completionClosure: @escaping () -> ()) {
//        //This resource is the same name as your xcdatamodeld contained in your project
//        guard let modelURL = Bundle.main.url(forResource: "CoreDataSample", withExtension: "momd") else {
//            fatalError("Error loading model from bundle")
//        }
//        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
//        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
//            fatalError("Error initializing mom from: \(modelURL)")
//        }
//        
//        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
//        
//        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
//        managedObjectContext.persistentStoreCoordinator = psc
//        
//        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
//        queue.async {
//            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
//                fatalError("Unable to resolve document directory")
//            }
//            let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
//            do {
//                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
//                //The callback block is expected to complete the User Interface and therefore should be presented back on the main queue so that the user interface does not need to be concerned with which queue this call is coming from.
//                DispatchQueue.main.sync(execute: completionClosure)
//            } catch {
//                fatalError("Error migrating store: \(error)")
//            }
//        }
//    }
    
    
    static let shared = CoreDataManager()
    
    private override init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecipesModel")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergePolicy(merge: .overwriteMergePolicyType)
        return context
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

