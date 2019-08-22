//
//  LoginViewController.swift
//  RickAndMorty
//
//  Created by omaestra on 21/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = self.emailTextField.text,
            let password = self.passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty
        
            else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error)
            } else {
                self.performSegue(withIdentifier: "goToMain", sender: nil)
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                let window = appDelegate.window
//                let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
//                window?.rootViewController = mainController
//                window?.makeKeyAndVisible()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

}
