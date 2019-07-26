//
//  ViewController.swift
//  NavigationSample
//
//  Created by omaestra on 24/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        passwordTextField.delegate = self
    }
    
    @IBAction func goToVC2(_ sender: Any) {
        self.performSegue(withIdentifier: "goToVC2", sender: nil)
    }
    
    @IBAction func unwindSegueToVC1(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        self.performSegue(withIdentifier: "goToMain", sender: email)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMain" {
            let destination = (segue.destination as! UINavigationController).topViewController as! SecondViewController
            if let email = sender as? String {
                destination.email = email
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
