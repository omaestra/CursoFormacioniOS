//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by omaestra on 31/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojis: [Emoji]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        if let emojis = Emoji.loadEmojisFromFile() {
            self.emojis = emojis
        } else {
            emojis = Emoji.loadLocalEmojis()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    // MARK: - Instance methods
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojis?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell

        guard let emoji = emojis?[indexPath.row] else { return UITableViewCell() }
        
        cell.setup(with: emoji)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let emoji = emojis?[indexPath.row] {
            print("\(emoji.symbol) \(indexPath)")
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if let movedEmoji = emojis?.remove(at: sourceIndexPath.row) {
            emojis?.insert(movedEmoji, at: destinationIndexPath.row)
            tableView.reloadData()
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditEmoji" {
            let destination = segue.destination as! EmojiFormTableViewController
            
            guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
            destination.emoji = emojis?[selectedIndex.row]
        }
    }
    
    @IBAction func unwindToEmojiTableController(_ sender: UIStoryboardSegue) {
        
        if sender.identifier == "saveUnwind" {
            guard let source = sender.source as? EmojiFormTableViewController, let emoji = source.emoji else { return }
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis?[selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: emojis?.count ?? 0, section: 0)
                emojis?.append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            Emoji.saveEmojisToFile(self.emojis!)
        }
    }

}
