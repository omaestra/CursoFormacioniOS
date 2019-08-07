//
//  ToDoListTableViewController.swift
//  List
//
//  Created by omaestra on 05/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search ToDos"
        navigationItem.searchController = searchController
//        definesPresentationContext = true
        return searchController
    }()
    
    var todos = [ToDoCoreData]()
    var filteredTodos = [ToDoCoreData]()
    
    var repository = TaskCoreDataRepository()
    
    override func viewDidLoad() {
         
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.searchController = searchController

        
        
//        if let savedToDos = ToDo.loadToDos() {
//            todos = savedToDos
//        } else {
//            todos = ToDo.loadSampleToDos()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        repository.fetch(ToDoCoreData.self, completion: { (data) in
            todos = data
            self.tableView.reloadData()
        })
    }
    
    func isFiltering() -> Bool {
        
        return !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return navigationItem.searchController?.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredTodos = todos.filter({( todo: ToDoCoreData) -> Bool in
            return todo.title?.lowercased().contains(searchText.lowercased()) ?? false
        })
        
        tableView.reloadData()
    }
    
    // MARK: - Table View Data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering() ? filteredTodos.count : todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoTableViewCell else {
            fatalError("Could not dequeue a cell.")
        }
        
        let todo: ToDoCoreData
        
        if isFiltering() {
            todo = filteredTodos[indexPath.row]
        } else {
            todo = todos[indexPath.row]
        }
        cell.titleLabel.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            repository.delete(item: todos[indexPath.row])
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            ToDo.saveToDos(todos)
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destination = storyboard.instantiateViewController(withIdentifier: "ToDoDetailsTableViewController") as! ToDoDetailsTableViewController
//
//        destination.todo = todos[indexPath.row]
//
//        self.navigationController?.pushViewController(destination, animated: true)
//    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        
        let sourceViewController = segue.source as! ToDoDetailsTableViewController
        
        if let todo = sourceViewController.todo {
            // Edit
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                repository.update(item: todo)
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Create
                repository.insert(item: todo)
                
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
//        ToDo.saveToDos(todos)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToDo" {
            let destination = segue.destination as! ToDoDetailsTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            
            let todo: ToDoCoreData
            if isFiltering() {
                todo = filteredTodos[indexPath.row]
            } else {
                todo = todos[indexPath.row]
            }
            
            destination.todo = todo
            destination.repository = self.repository
            
        } else if segue.identifier == "CreateToDo" {
            guard let destination = (segue.destination as? UINavigationController)?.topViewController as? ToDoDetailsTableViewController else { return }
            
            destination.repository = repository
        }
    }

}

// MARK: - ToDo Cell Delegate

extension ToDoListTableViewController: ToDoCellDelegate {
    
    func checkMarkTapped(_ sender: ToDoTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            let todo = todos[indexPath.row]
            
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            repository.update(item: todo)
//            ToDo.saveToDos(todos)
        }
    }
}

//extension ToDoListTableViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterContentForSearchText(searchText)
//    }
//}

extension ToDoListTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
