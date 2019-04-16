

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var bgColor :UIColor? = nil
    var bgColorDark :UIColor? = nil
    
    var toID :Int? = nil
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismissAction()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initVC()
        //titleLabel.hero.id = "TITLE_\(toID!)"
        //self.view.hero.id = "VIEW_\(toID!)"
        
        
        backBtnView.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(backActions(_:))))

    }
    
    @objc func backActions(_ sender:UITapGestureRecognizer?){
        //print("TAPPED")
        self.dismissAction()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       /* if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }*/
    }

}
