import UIKit
import SpriteKit
class ViewController: UIViewController {
    
    @IBAction func button(_ sender: Any) {
        performSegue(withIdentifier: "ModalSegue", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                let sanjiao =  TestSanJiao()
        
                sanjiao.frame = CGRect(x: 100, y: 230, width: 130, height: 130)
                self.view.backgroundColor = UIColor.white
                sanjiao.backgroundColor = UIColor.white
        
                self.view.addSubview(sanjiao)
    }

  
}

