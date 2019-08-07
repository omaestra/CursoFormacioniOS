//
//  TaskCoreDataRepository.swift
//  List
//
//  Created by omaestra on 05/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataRepository {
    associatedtype T
    
    func create<T: NSManagedObject>() -> T
}

class TaskCoreDataRepository: Repository, CoreDataRepository {
    
    typealias T = ToDoCoreData
    
    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.viewContext
    }
    
    func create<T>() -> T where T : NSManagedObject {
        return ToDoCoreData(entity: ToDoCoreData.entity(), insertInto: context) as! T
    }
    
    /*
     Return a list of objects.
     */
    func fetch(_ model: ToDoCoreData.Type, predicate: NSPredicate? = nil, completion: (([ToDoCoreData]) -> ())) {
        
        let fetchRequest: NSFetchRequest<ToDoCoreData> = ToDoCoreData.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            completion(results)
        } catch {
            debugPrint(error)
            completion([])
        }
    }
    
    func getAll() -> [ToDoCoreData] {
        let fetchRequest: NSFetchRequest<ToDoCoreData> = ToDoCoreData.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            debugPrint(error)
        }
        
        return []
    }
    
    func getById(id: String) -> ToDoCoreData {
        return ToDoCoreData(entity: ToDoCoreData.entity(), insertInto: context)
    }
    
    func insert(item: ToDoCoreData) {
        do {
            context.insert(item)
            try context.save()
        } catch {
            debugPrint(error)
        }
    }
    
    func update(item: ToDoCoreData) {
//        let fetchRequest: NSFetchRequest<ToDoCoreData> = ToDoCoreData.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id = %@", item.objectID)
        do {
//            let fetchResult = try context.fetch(fetchRequest)
            
            var updateObject = context.object(with: item.objectID)
            updateObject = item
            
            try context.save()
        } catch (let error) {
            debugPrint("Error updating data. \(error.localizedDescription)")
        }
    }
    
    func clean() {
        return
    }
    
    func delete(item: ToDoCoreData) {
        do {
            context.delete(item)
            
            try context.save()
        } catch {
            debugPrint(error)
        }
    }
}
