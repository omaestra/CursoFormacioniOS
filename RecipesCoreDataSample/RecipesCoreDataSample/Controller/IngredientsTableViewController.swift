//
//  IngredientsTableViewController.swift
//  RecipesCoreDataSample
//
//  Created by omaestra on 04/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit
import CoreData

class IngredientsTableViewController: UITableViewController {
    
    var ingredients: [IngredientMO] = []
    var selectedIngredients: [IngredientMO] {
        guard let selectedIndexes = tableView.indexPathsForSelectedRows else { return [] }
        
        var ingredients: [IngredientMO] = []
        for indexPath in selectedIndexes {
            ingredients.append(self.ingredients[indexPath.row])
        }
        
        return ingredients
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearData()
        saveSomeIngredients()
        ingredients = loadIngredients()
        
        tableView.reloadData()
    }
    
    func saveSomeIngredients() {
        let context = CoreDataManager.shared.mainContext
        let ingredient = IngredientMO(entity: IngredientMO.entity(), insertInto: context)
        ingredient.name = "Cheese"
        ingredient.calories = 40
        
        let ingredient2 = IngredientMO(entity: IngredientMO.entity(), insertInto: context)
        ingredient2.name = "Milk"
        ingredient2.calories = 10
        
        let ingredient3 = IngredientMO(entity: IngredientMO.entity(), insertInto: context)
        ingredient3.name = "Bacon"
        ingredient3.calories = 200
        
        CoreDataManager.shared.saveContext()
    }
    
    func clearData() {
        let context = CoreDataManager.shared.mainContext
        
        do {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = IngredientMO.fetchRequest()
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
            } catch (let error) {
                print("Error deleting all objects. \(error.localizedDescription)")
            }
        }
    }
    
    func loadIngredients() -> [IngredientMO] {
        let context = CoreDataManager.shared.mainContext
        
        // 1
        let request: NSFetchRequest<IngredientMO> = IngredientMO.fetchRequest()
        
        // 2
        //        request.predicate = NSPredicate(format: "title = %@", "MEDIUM")
        do {
            // 3
            let ingredients = try context.fetch(request)
            
            // 4
            ingredients.forEach { ingredient in
                print(ingredient.name)
            }
            
            return ingredients
        }  catch {
            fatalError("This was not supposed to happen")
        }
        
        return []

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ingredients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)

        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func doneButtonTapped(_ sender: Any) {

    }
}
