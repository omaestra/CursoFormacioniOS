//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by omaestra on 20/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var numbersPad: [UIButton]!
    
    enum Operation: String {
        case divide = "/"
        case multiply = "*"
        case substract = "-"
        case sumUp = "+"
        case percentage = "%"
        case empty = ""
    }
    
    var operation: Operation = .empty
    var currentNumber: String = ""
    var leftValue: String?
    var rightValue: String?
    var result: String? {
        didSet {
            self.resultLabel.text = "\(result ?? "")"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func calculate(operation: Operation) {
        if self.operation != .empty {
            guard currentNumber != "" else { return }
            
            rightValue = currentNumber
            currentNumber = ""
            
            switch operation {
            case .sumUp:
                if let leftValue = Double(leftValue ?? ""), let rightValue = Double(rightValue ?? "") {
                    self.result = "\(leftValue + rightValue)"
                }
            case .divide:
                break
            case .multiply:
                break
            case .substract:
                break
            case .percentage:
                break
            case .empty:
                break
            }
            
            leftValue = result
        } else {
            leftValue = currentNumber
            currentNumber = ""
        }
        
        self.operation = operation
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        currentNumber += sender.currentTitle ?? ""
        self.resultLabel.text = currentNumber
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        operation = .empty
        self.resultLabel.text = "0"
        
        currentNumber = ""
        result = nil
    }

    @IBAction func onEqualPressed(_ sender: Any) {
        self.calculate(operation: self.operation)
    }
    
    @IBAction func onSumUpPressed(_ sender: Any) {
        self.calculate(operation: .sumUp)
    }
}
