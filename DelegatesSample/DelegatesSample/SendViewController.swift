//
//  SendViewController.swift
//  DelegatesSample
//
//  Created by omaestra on 18/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

protocol UpdateTextDelegate {
    func updateLabel(with text: String)
}

class SendViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    
    var delegate: UpdateTextDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        
        guard let text = inputTextField.text else { return }
        
        delegate?.updateLabel(with: text)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
