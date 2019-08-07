//
//  RecipeCoreDataRepository.swift
//  RecipesCoreDataSample
//
//  Created by omaestra on 04/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation
import CoreData

class RecipeCoreDataRepository: Repository {
    
    func getAll() -> [RecipeMO]? {
        let mainContext = CoreDataManager.shared.mainContext
        let fetchRequest: NSFetchRequest<RecipeMO> = RecipeMO.fetchRequest()
        
        do {
            let results = try mainContext.fetch(fetchRequest)
            return results
        } catch {
            debugPrint(error)
        }
        
        return nil
    }
    
    func get(identifier: Int) -> RecipeMO? {
        let managedContext = CoreDataManager.shared.mainContext
        
        let fetchRequest: NSFetchRequest<RecipeMO> = RecipeMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", identifier)
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest)
            return fetchResult.first
        } catch (let error) {
            debugPrint("Error updating data. \(error.localizedDescription)")
            return nil
        }
    }
    
    func get(byName name: String) -> RecipeMO? {
        let managedContext = CoreDataManager.shared.mainContext
        
        let fetchRequest: NSFetchRequest<RecipeMO> = RecipeMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest)
            return fetchResult.first
        } catch (let error) {
            debugPrint("Error updating data. \(error.localizedDescription)")
            return nil
        }
    }
    
    func create() -> RecipeMO {
        let context = CoreDataManager.shared.mainContext
        
        let entity = RecipeMO.entity()
        let newRecipe = RecipeMO(entity: entity, insertInto: context)
        
        return newRecipe
        
//        do {
//            try context.save()
//            return true
//        } catch {
//            debugPrint(error)
//            return false
//        }
    }
    
    func update(model: RecipeMO) -> Bool {
        let managedContext = CoreDataManager.shared.mainContext
        
        let fetchRequest: NSFetchRequest<RecipeMO> = RecipeMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", model.name!)
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest)
            
            let updateObject = fetchResult[0]
            updateObject.name = model.name
            
            try managedContext.save()
            return true
        } catch (let error) {
            debugPrint("Error updating data. \(error.localizedDescription)")
            return false
        }
    }
    
    func delete(model: RecipeMO) -> Bool {
        let managedContext = CoreDataManager.shared.mainContext
        
        do {
            managedContext.delete(model)
            
            try managedContext.save()
            return true
        } catch (let error) {
            print("Error deleting object. \(error.localizedDescription)")
            return false
        }
    }
    
    typealias T = RecipeMO

    
    
}
