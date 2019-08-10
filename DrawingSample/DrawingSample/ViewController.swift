//
//  ViewController.swift
//  DrawingSample
//
//  Created by omaestra on 08/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cardViews: [CardView]! {
        didSet {
            cardViews.forEach({
                let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
                swipe.direction = [.left, .right]
                //            swipe.numberOfTouchesRequired = 2
                $0.addGestureRecognizer(swipe)
                
                let pinchSelector = #selector($0.adjustCardViewScale(byHandlingGestureRecognizerBy:))
                let pinch = UIPinchGestureRecognizer(target: $0, action: pinchSelector)
                $0.addGestureRecognizer(pinch)
                
                let pan = UIPanGestureRecognizer(target: self, action: #selector(panCard))
                $0.addGestureRecognizer(pan)
                
            })
        }
    }
    
    @IBOutlet weak var cardView: CardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
//            swipe.numberOfTouchesRequired = 2
            cardView.addGestureRecognizer(swipe)
            
            let pinchSelector = #selector(cardView.adjustCardViewScale(byHandlingGestureRecognizerBy:))
            let pinch = UIPinchGestureRecognizer(target: cardView, action: pinchSelector)
            cardView.addGestureRecognizer(pinch)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @objc func nextCard(_ sender: UISwipeGestureRecognizer) {
        (sender.view as! CardView).icon = "🤯"
        (sender.view as! CardView).titleString = "¡BOOM!"
    }
    
    @objc func panCard(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            let translationInView = sender.translation(in: self.view)
            if translationInView.x < -200 {
                sender.view!.removeFromSuperview()
            }
            
            sender.view!.transform = CGAffineTransform(translationX: sender.translation(in: self.view).x, y: sender.translation(in: self.view).y)
        case .ended:
            UIView.animate(withDuration: 0.3) {
                sender.view!.transform = CGAffineTransform.identity
            }
        default:
            break
        }
    }
    
    @IBAction func tapCard(_ sender: UITapGestureRecognizer) {
        UIView.transition(with: (sender.view as! CardView), duration: 0.6, options: [.transitionFlipFromLeft], animations: {
            (sender.view as! CardView).isFaceUp = !(sender.view as! CardView).isFaceUp
        }, completion: nil)
    }
    
}

