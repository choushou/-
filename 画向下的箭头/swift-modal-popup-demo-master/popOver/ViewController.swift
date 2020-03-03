import UIKit
import SpriteKit
class ViewController: UIViewController {
    
    @IBAction func button(_ sender: Any) {
        performSegue(withIdentifier: "ModalSegue", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let sanjiao = TestSanJiao()
        sanjiao.frame = CGRect(x: 150, y: 200, width: 30, height: 30)
        self.view.backgroundColor = UIColor.white
        sanjiao.backgroundColor = UIColor.white
        
        self.view.addSubview(sanjiao)
        
    }

  
}

