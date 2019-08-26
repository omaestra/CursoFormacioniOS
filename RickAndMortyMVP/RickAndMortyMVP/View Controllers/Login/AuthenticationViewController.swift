//
//  AuthenticationViewController.swift
//  RickAndMortyMVP
//
//  Created by omaestra on 23/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthenticationViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = Auth.auth().currentUser {
            //            let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
            //            self.present(mainController, animated: true, completion: nil)
            self.performSegue(withIdentifier: "goToMain", sender: self)
            
        } else {
            //            let loginController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: <#T##String#>)
            //            self.present(loginController, animated: true, completion: nil)
            
            self.performSegue(withIdentifier: "goToLogin", sender: self)
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func unwindToMainViewController(_ unwindSegue: UIStoryboardSegue) {
        //        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

}
