//
//  EmojiFormTableViewController.swift
//  EmojiDictionary
//
//  Created by omaestra on 31/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class EmojiFormTableViewController: UITableViewController {
    
    var emoji: Emoji?

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [symbolTextField, nameTextField, descriptionTextField, usageTextField].forEach({ $0?.delegate = self })
        
        tableView.tableFooterView = UIView()

        if let emoji = emoji {
            symbolTextField.text = String(emoji.symbol)
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel(_:)))
        }
        
        updateSaveButtonState()
    }

    @objc func handleCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "cancelUnwind", sender: self)
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let symbol = symbolTextField.text?.first,
            let name = nameTextField.text,
            let description = descriptionTextField.text,
            let usage = usageTextField.text
        else { return }
        
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
        
        self.performSegue(withIdentifier: "saveUnwind", sender: self)
    }
    
    func updateSaveButtonState() {
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
    
        saveButton.isEnabled = !symbolText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EmojiFormTableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
}
