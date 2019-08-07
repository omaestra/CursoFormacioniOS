//
//  RecipesTableViewController.swift
//  RecipesCoreDataSample
//
//  Created by omaestra on 03/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var recipes: [RecipeMO]? = []
    var repository = RecipeCoreDataRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        recipes = repository.getAll()
        self.tableView.reloadData()
        
//        recipes = RecipeDAO.shared.loadRecipes()
//        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)

        let recipe = recipes?[indexPath.row]
        cell.textLabel?.text = recipe?.name
        
        if let ingredients = recipe?.ingredients?.allObjects as? [IngredientMO] {
            cell.detailTextLabel?.text = ingredients.compactMap({ $0.name }).joined(separator: ", ")
        }

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let recipe = recipes?[indexPath.row] else { return }
            
            if repository.delete(model: recipe) {
                self.recipes?.remove(at: indexPath.row)
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditRecipe" {
            guard let destination = segue.destination as? RecipeFormTableViewController,
                let selectedIndex = tableView.indexPathForSelectedRow else { return }
            destination.recipe = self.recipes?[selectedIndex.row]
        }
    }

    @IBAction func unwindToRecipes(_ unwindSegue: UIStoryboardSegue) {
        guard let source = unwindSegue.source as? RecipeFormTableViewController,
            let recipe = source.recipe else { return }
        
        if let selectIndex = tableView.indexPathForSelectedRow {
            
        } else {
//            recipes?.append(recipe)
//            self.tableView.reloadData()
        }
    }
}
