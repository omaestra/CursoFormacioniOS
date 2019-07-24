//
//  ApplePieCodingLayoutViewController.swift
//  ApplePie
//
//  Created by omaestra on 23/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ApplePieCodingLayoutViewController: UIViewController {

    var treeImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "Tree 0")!
        imageView.backgroundColor = .green
        return imageView
    }()
    
    var buttonCollection: [UIButton] = [UIButton]()
    
    var resultLabel: UILabel! = UILabel()
    var otherLabel: UILabel! = UILabel()
    
    let letters: [String] = ["A", "B", "C", "D", "E" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(treeImageView)
        self.view.addSubview(resultLabel)
        
        resultLabel.text = "RESULT LABEL"
        resultLabel.font = UIFont(name: "Helvetica", size: 45)

//        NSLayoutConstraint(item: resultLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
       
//        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "|-[label]-|", options: .alignAllTop, metrics: nil, views: ["label": resultLabel])
//
//        NSLayoutConstraint.activate(constraints)
        treeImageView.translatesAutoresizingMaskIntoConstraints = false
        treeImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        treeImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50.0).isActive = true
        treeImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: resultLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        
        
        let constraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: .alignAllTop, metrics: nil, views: ["label": resultLabel])
        
        let constraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-|", options: .alignAllTop, metrics: nil, views: ["label": resultLabel])
        
        NSLayoutConstraint.activate(constraintsH + constraintsV)
//        resultLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        resultLabel.topAnchor.constraint(equalTo: treeImageView.bottomAnchor, constant: 24.0).isActive = true
        resultLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        resultLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        
        treeImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        letters.forEach({
            let button = UIButton()
            button.setTitle($0, for: .normal)
            button.addTarget(self, action: Selector(("clickButton")), for: .touchUpInside)
            
            buttonCollection.append(button)
        })
    }
    
    func clickButton(_ sender: UIButton) {
        
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
