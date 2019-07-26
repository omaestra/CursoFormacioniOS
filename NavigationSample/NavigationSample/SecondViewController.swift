//
//  SecondViewController.swift
//  NavigationSample
//
//  Created by omaestra on 24/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.title = email
        welcomeLabel.text = "Welcome, \(email ?? "")"
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
