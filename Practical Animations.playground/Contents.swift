import UIKit
import PlaygroundSupport

let liveViewFrame = CGRect(x: 0, y: 0, width: 500, height: 500)
let liveView = UIView(frame: liveViewFrame)

let viewFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
let view = UIView(frame: viewFrame)
//liveView.addSubview(view)

PlaygroundPage.current.liveView = liveView
view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

/// Simple animation

//UIView.animate(withDuration: 5.5, animations: {
//    view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
//}) { (finished) in
//    print(finished)
//}


/// Contained animations

//UIView.animate(withDuration: 3.0, animations: {
//    view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
//    view.frame = CGRect(x: 150, y: 150, width: 200, height: 200)
//}) { (_) in
//    UIView.animate(withDuration: 3.0, animations: {
//        view.backgroundColor = .white
//        view.frame = viewFrame
//    })
//}

/// Autoreverse animation

//UIView.animate(withDuration: 3.0, delay: 0.0, options: [.autoreverse], animations: {
//    view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
//    view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//}) { (_) in
//    liveView.backgroundColor = .gray
//    view.removeFromSuperview()
//}

let progressBar = UIProgressView(progressViewStyle: .bar)
progressBar.frame = CGRect(x: 100, y: 100, width: 300, height: 500)

progressBar.transform = CGAffineTransform(scaleX: 1.0, y: 3.0)
progressBar.progress = 0.5
progressBar.backgroundColor = .green
liveView.addSubview(progressBar)

//UIView.animate(withDuration: 3.0, delay: 2.0, options: [.autoreverse, .repeat], animations: {
//    view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
//    view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//}, completion: nil)


/// Transform

//let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
//let rotateTransform = CGAffineTransform(rotationAngle: .pi)
//let translateTransform = CGAffineTransform(translationX: 200, y: 200)
//
//UIView.animate(withDuration: 2.0, animations: {
//    view.backgroundColor = .orange
//
//    let comboTransform = scaleTransform.concatenating(rotateTransform).concatenating(translateTransform)
//
//    view.transform = comboTransform
//}) { (_) in
//    UIView.animate(withDuration: 2.0, delay: 2.0, animations: {
//        view.transform = CGAffineTransform.identity
//    })
//}
//let animation = CABasicAnimation(keyPath: "position")
//animation.duration = 0.07
//animation.autoreverses = true
//animation.repeatCount = 5
//animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
//animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
//
//view.layer.add(animation, forKey: "shake")




//let ints = [1, 2, 3, 4, 5, 6]
//ints.reduce(0) { (value1, value2) -> Int in
//    return value1 + value2
//}
