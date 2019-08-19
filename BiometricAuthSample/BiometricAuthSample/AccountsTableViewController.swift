//
//  AccountsTableViewController.swift
//  BiometricAuthSample
//
//  Created by omaestra on 18/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class AccountsTableViewController: UITableViewController {

    let cellReuseIdentifier = "Cell"
    
    var passwordItems = [KeychainPasswordItem]()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Localize the title using app-specific localizations.
        navigationItem.title = NSLocalizedString("AccountsViewControllerTitle", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
         Make sure the table view is up-to-date by first reloading the
         password items from the keychain and then reloading the table view.
         */
        do {
            passwordItems = try KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName, accessGroup: KeychainConfiguration.accessGroup)
        }
        catch {
            fatalError("Error fetching password items - \(error)")
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let navigationController = segue.destination as? UINavigationController,
            let accountViewController = navigationController.topViewController as? AccountDetailsTableViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            /*
             Set the account name on the `AccountDetailsViewController` that
             is about to be displayed to the account name of the selected cell.
             */
            let passwordItem = passwordItems[indexPath.row]
            accountViewController.accountName = passwordItem.account
        }
    }
    
    // MARK: Unwind segues
    
    @IBAction func unwindToAccountsView(_ segue: UIStoryboardSegue) {
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwordItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let passwordItem = passwordItems[indexPath.row]
        
        cell.textLabel?.text = passwordItem.account
        
        return cell
    }
    
    // MARK: UITableViewDataDelegate
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { action, indexPath in
            // Try to delete the item from the keychain.
            let passwordItem = self.passwordItems[indexPath.row]
            do {
                try passwordItem.deleteItem()
            }
            catch {
                fatalError("Error deleting keychain item - \(error)")
            }
            
            // Delete the item from the `passwordItems` array.
            self.passwordItems.remove(at: indexPath.row)
            
            // Delete the item from the table view
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction]
    }

}
