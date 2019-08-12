//
//  RegistrationTableViewController.swift
//  HotelCordoba
//
//  Created by omaestra on 01/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    
    var modelController = RegistrationController()
    
    var registrations: [Registration] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let registrations = modelController.loadRegistrationsFromFile() {
            self.registrations = registrations
        }
        
        self.navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registrationCell", for: indexPath)

        let registration = registrations[indexPath.row]

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        cell.textLabel?.text = "\(registration.firstName) \(registration.lastName)"
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: registration.checkInDate, to: registration.checkOutDate)
        
        let nights = components.day ?? 0
        
//        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " +  dateFormatter.string(from: registration.checkOutDate) + " : " + registration.roomType.name
        
        let formatString = NSLocalizedString("%d nights",
                                             comment: "Registration's numbers of nights")
        cell.detailTextLabel?.text = String.localizedStringWithFormat(formatString, nights)
        
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

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            registrations.remove(at: indexPath.row)
            modelController.saveRegistrationsToFile(registrations)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        
    }
    
    @IBAction func unwindToRegistrationTableViewController(_ unwindSegue: UIStoryboardSegue) {
        guard let sourceViewController = unwindSegue.source as? AddRegistrationTableViewController, let registration = sourceViewController.registration else { return }
        
        registrations.append(registration)
        
        modelController.saveRegistrationsToFile(registrations)
        
        tableView.reloadData()
    }

}
