import UIKit
import SpriteKit
class ViewController: UIViewController {
    
    @IBAction func button(_ sender: Any) {
        performSegue(withIdentifier: "ModalSegue", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                let sanjiao =  TestSanJiao()
        
                sanjiao.frame = CGRect(x: 50, y: 30, width: 230, height: 230)
                self.view.backgroundColor = UIColor.red
                sanjiao.backgroundColor = UIColor.green
        
                self.view.addSubview(sanjiao)
    }

  
}

