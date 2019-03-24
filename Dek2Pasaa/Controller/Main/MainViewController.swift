import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    let primaryColor :PrimaryColor = PrimaryColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.white
        self.mainView.backgroundColor = UIColor.white

    }

}
