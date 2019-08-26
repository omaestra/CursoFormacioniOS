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
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var showRegisterFormButton: UIButton!
    
    var isRegister: Bool = false {
        didSet {
            confirmPasswordTextField.isHidden = isRegister ? false : true
            loginButton.isHidden = isRegister ? true : false
            registerButton.isHidden = isRegister ? false : true
            
            if isRegister {
                showRegisterFormButton.setTitle("Back to Log In", for: .normal)
            } else {
                showRegisterFormButton.setTitle("Don't have an account? Register", for: .normal)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        print("DEBUG")
        #endif
        
        #if RELEASE
        print("RELEASE")
        #endif
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
//                self.performSegue(withIdentifier: "goToMain", sender: nil)
                self.dismiss(animated: true, completion: nil)
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                let window = appDelegate.window
//                let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
//                window?.rootViewController = mainController
//                window?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func showRegisterButtonTapped(_ sender: UIButton) {
        isRegister = !isRegister
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
