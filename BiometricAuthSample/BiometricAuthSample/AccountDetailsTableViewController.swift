//
//  AccountDetailsTableViewController.swift
//  BiometricAuthSample
//
//  Created by omaestra on 18/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class AccountDetailsTableViewController: UITableViewController {

    // MARK: Dependency injection properties
    
    var accountName: String?
    
    // MARK: Interface Builder outlets
    
    @IBOutlet var accountNameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var clearTextSwitch: UISwitch!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If an account name has been set, read any existing password from the keychain.
        if let accountName = accountName {
            do {
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: accountName, accessGroup: KeychainConfiguration.accessGroup)
                
                accountNameField.text = passwordItem.account
                passwordField.text = try passwordItem.readPassword()
            }
            catch {
                fatalError("Error reading password from keychain - \(error)")
            }
        }
        
        // Update the save button state to reflect the state of the text fields.
        updateSaveButtonState()
    }
    
    // MARK: Interface Builder actions
    
    @IBAction func textFieldChanged(_ sender: AnyObject) {
        updateSaveButtonState()
    }
    
    @IBAction func toggleClearText(_: AnyObject) {
        passwordField.isSecureTextEntry = !clearTextSwitch.isOn
    }
    
    @IBAction func save(_ sender: AnyObject) {
        // Check that text has been entered into both the account and password fields.
        guard let newAccountName = accountNameField.text, let newPassword = passwordField.text, !newAccountName.isEmpty && !newPassword.isEmpty else { return }
        
        // Check if we need to update an existing item or create a new one.
        do {
            if let originalAccountName = accountName {
                // Create a keychain item with the original account name.
                var passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: originalAccountName, accessGroup: KeychainConfiguration.accessGroup)
                
                // Update the account name and password.
                try passwordItem.renameAccount(newAccountName)
                try passwordItem.savePassword(newPassword)
            }
            else {
                // This is a new account, create a new keychain item with the account name.
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: newAccountName, accessGroup: KeychainConfiguration.accessGroup)
                
                // Save the password for the new item.
                try passwordItem.savePassword(newPassword)
            }
        }
        catch {
            fatalError("Error updating keychain - \(error)")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateSaveButtonState() {
        guard isViewLoaded else { return }
        
        // Enable the save button if both account and password fields contain text.
        if let newAccount = accountNameField.text, let newPassword = passwordField.text, !newAccount.isEmpty && !newPassword.isEmpty {
            saveButton?.isEnabled = true
        }
        else {
            saveButton?.isEnabled = false
        }
    }

}
