//
//  RecipeDAO.swift
//  RecipesCoreDataSample
//
//  Created by omaestra on 03/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation
import CoreData

class RecipeDAO {
    static let shared = RecipeDAO()
    
    private init() {}
    
    func loadRecipes() -> [RecipeMO]? {
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
    
    func save(recipe: RecipeMO) throws {
        let context = CoreDataManager.shared.mainContext
        
        let entity = RecipeMO.entity()
        let newRecipe = RecipeMO(entity: entity, insertInto: context)
        
        newRecipe.name = recipe.name
        
        do {
            try context.save()
        } catch {
            debugPrint(error)
        }
    }
    
    func save(recipe: RecipeMO, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) throws {
        let context = CoreDataManager.shared.backgroundContext()
        context.perform {
            do {
                let entity = RecipeMO.entity()
                let newRecipe = RecipeMO(entity: entity, insertInto: context)
                newRecipe.name = recipe.name
                newRecipe.ingredients = recipe.ingredients
                
                try context.save()
                
                completion(true, nil)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func update(recipe: RecipeMO) {
        let managedContext = CoreDataManager.shared.backgroundContext()
        
        let fetchRequest: NSFetchRequest<RecipeMO> = RecipeMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", recipe.name!)
        
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest)
            
            let updateObject = fetchResult[0]
            updateObject.name = recipe.name
            
            try managedContext.save()
        } catch (let error) {
            debugPrint("Error updating data. \(error.localizedDescription)")
        }
    }
    
    func delete(by name: String, _ completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        let managedContext = CoreDataManager.shared.backgroundContext()
        
        let fetchRequest: NSFetchRequest<RecipeMO> = RecipeMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest)
            
            guard let objectToDelete = fetchResult.first else { return }
            managedContext.perform {
                managedContext.delete(objectToDelete)
                completion(true, nil)
            }
            
            try managedContext.save()
        } catch (let error) {
            print("Error deleting object. \(error.localizedDescription)")
        }
    }
    
    func delete(recipe: RecipeMO) {
        let managedContext = CoreDataManager.shared.backgroundContext()
        
        do {
            managedContext.delete(recipe)
            
            try managedContext.save()
        } catch (let error) {
            print("Error deleting object. \(error.localizedDescription)")
        }
    }
    
    func deleteAll() {
        let managedContext = CoreDataManager.shared.backgroundContext()
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = RecipeMO.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch (let error) {
            print("Error deleting all objects. \(error.localizedDescription)")
        }
    }
}
