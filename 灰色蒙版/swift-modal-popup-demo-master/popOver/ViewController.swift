import UIKit

class ViewController: UIViewController {
    
    @IBAction func button(_ sender: Any) {
        performSegue(withIdentifier: "ModalSegue", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

