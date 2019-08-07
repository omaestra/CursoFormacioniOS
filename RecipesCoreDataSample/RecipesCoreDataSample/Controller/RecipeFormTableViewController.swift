//
//  RecipeFormTableViewController.swift
//  RecipesCoreDataSample
//
//  Created by omaestra on 03/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class RecipeFormTableViewController: UITableViewController {

    @IBOutlet weak var recipeNameTextField: UITextField!
    
    var recipe: RecipeMO?
    var ingredients: [IngredientMO]?
    var repository = RecipeCoreDataRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ingredientsCell")

        if let recipe = recipe {
            self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem
            
            setupViews()
        } else {
        }
    }
    
    func setupViews() {
        self.recipeNameTextField.text = recipe?.name
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section, indexPath.row) == (1, 0) {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ingredientsCell")
            
            cell.textLabel?.text = "Ingredients"
            cell.detailTextLabel?.text = ingredients?.compactMap({ $0.name }).joined(separator: ", ")
            
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section, indexPath.row) == (1, 0) {
            self.performSegue(withIdentifier: "toIngredients", sender: self)
        }
    }
    
    @IBAction func handleSave(_ sender: Any) {
        guard let name = recipeNameTextField.text else { return }
        
        if let recipe = recipe, let oldName = recipe.name {
            let recipeToUpdate = repository.get(byName: oldName)
            recipeToUpdate?.name = name
            if let ingredients = ingredients {
                recipeToUpdate?.ingredients = NSSet(array: ingredients)
            }
        } else {
            let recipe = repository.create()
            recipe.name = name
            recipe.addToIngredients(NSSet(array: ingredients!))
        }
        
        CoreDataManager.shared.saveContext()
        
        if self.recipe != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    @IBAction func unwindToRecipeFormViewController(_ unwindSegue: UIStoryboardSegue) {
        guard let sourceViewController = unwindSegue.source as? IngredientsTableViewController else { return }
        
//        recipe?.addToIngredients(NSSet(array: sourceViewController.selectedIngredients))
        ingredients = sourceViewController.selectedIngredients
        tableView.reloadData()
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
