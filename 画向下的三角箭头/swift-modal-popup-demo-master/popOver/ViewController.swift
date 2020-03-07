import UIKit
import SpriteKit
class ViewController: UIViewController {
    
    @IBAction func button(_ sender: Any) {
        performSegue(withIdentifier: "ModalSegue", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let sanjiao = TestSanJiao()
//        sanjiao.frame = CGRect(x: 250, y: 400, width: 30, height: 30)
//        self.view.backgroundColor = UIColor.white
//        sanjiao.backgroundColor = UIColor.white
//
//        self.view.addSubview(sanjiao)
        
        
                let sanjiao = TestSanJiao()
                sanjiao.frame = CGRect(x: 250, y: 300, width: 30, height: 30)
                self.view.backgroundColor = UIColor.white
                sanjiao.backgroundColor = UIColor.white
        
                self.view.addSubview(sanjiao)
    }

  
}

