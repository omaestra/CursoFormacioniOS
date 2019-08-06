//
//  ViewController.swift
//  CoreDataSample
//
//  Created by omaestra on 12/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        deleteAll()
        createData()
        retrieveData()
        updateData()
        retrieveData()
        deleteData()
        retrieveData()
    }


    func createData() {
        debugPrint("Saving Task...")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext) else { return }
        
        let task = NSManagedObject(entity: taskEntity, insertInto: managedContext)
        task.setValue("Visit Cordoba", forKey: "name")
        task.setValue(false, forKey: "completed")
        
        do {
            try managedContext.save()
            debugPrint("Saved Task. \(task.value(forKey: "name") ?? "")")
        } catch (let error) {
            debugPrint("Error saving Task. \(error.localizedDescription)")
        }
    }
    
    func retrieveData() {
        debugPrint("Retrieving Tasks...")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
            }
            debugPrint("Retrieved Tasks data. \(result) ")
        } catch (let error) {
            debugPrint("Error retrieving values from entity Task. \(error.localizedDescription)")
        }
    }
    
    func updateData() {
        debugPrint("Updating Tasks...")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Visit Cordoba")
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest)
            
            let updateObject = fetchResult[0]
            updateObject.name = "Visit Madrid"
            updateObject.completed = true
            
            try managedContext.save()
        } catch (let error) {
            debugPrint("Error updating data. \(error.localizedDescription)")
        }
    }
    
    func deleteAll() {
        debugPrint("Deleting all Tasks...")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Task.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch (let error) {
            print("Error deleting object. \(error.localizedDescription)")
        }
    }
    
    func deleteData() {
        debugPrint("Delete Task...")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Visit Madrid")
        
        do {
            let fetchResult = try managedContext.fetch(fetchRequest)
            
            guard let objectToDelete = fetchResult.first else { return }
            managedContext.delete(objectToDelete)
            
            try managedContext.save()
        } catch (let error) {
            print("Error deleting object. \(error.localizedDescription)")
        }
    }
}

