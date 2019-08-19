//
//  ViewController.swift
//  BiometricAuthSample
//
//  Created by omaestra on 18/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet var successLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchIdAction(_ sender: UIButton) {
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authentication Test"
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            self.successLabel.text = "User authenticated successfully"
                        } else {
                            self.successLabel.text = "User couldn't authenticate successfully"
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                print(authError)
                successLabel.text = "Error evaluating policy."
            }
        } else {
            // Fallback on earlier versions
            successLabel.text = "Feature not supported."
        }
    }

}

