//
//  CharactersTableViewController.swift
//  RickAndMorty
//
//  Created by Usuario on 14/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CharactersTableViewController: UITableViewController {

    var characters: [Character] = []
    var pagedData: PagedData<Character>?
    
    private let presenter = CharactersPresenter(service: CharacterService())
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = activityIndicator

        self.refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        presenter.setViewDelegate(delegate: self)
        presenter.loadCharacters()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
//        loadCharacters()
    }
    
    private func fetchNextPage() {
//        loadCharacters()
    }
    
    private func isLoading(at indexPath: IndexPath) -> Bool {
        return indexPath.row == self.characters.count-1
    }

    // MARK: - Actions
    
    @IBAction func handleLogOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            self.performSegue(withIdentifier: "unwindToLogin", sender: nil)
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let loginController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
//            appDelegate.window?.rootViewController = loginController
//            appDelegate.window?.makeKeyAndVisible()
        } catch {
            print("[ERROR]: Couldn't log out user.")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.characters.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard isLoading(at: indexPath) else { return }
        
        self.fetchNextPage()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell

        let character = characters[indexPath.row]
        
        cell.nameLabel.text = character.name
        cell.characterImageView.loadImage(fromURL: character.image)
        cell.speciesLabel.text = "\(character.species)"
        
        if character.type != "" {
            cell.speciesLabel.text?.append(" - \(character.type)")
        }
        
        cell.genderLabel.text = character.gender
        cell.statusLabel.text = character.status.rawValue
        cell.statusLabel.textColor = character.status.color

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacter" {
            let destination = segue.destination as! CharacterDetailsTableViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.character = characters[indexPath.row]
            }
        }
    }

}

extension CharactersTableViewController: CharacterViewDelegate {
    func displayCharacters(pagedData: PagedData<Character>) {
        self.pagedData = pagedData
        self.characters = pagedData.results
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
