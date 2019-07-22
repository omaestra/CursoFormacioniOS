import UIKit

class ViewController: UIViewController {
    
    var number: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var sample = "sample"
        print(sample)
        
        var prueba = 5
        
        if false {
            print("Will this line of code ever be reached?")
            someMethod()
        }
        
        
    }
    
    
    func someMethod() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


