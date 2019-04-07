

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    var bgColor :UIColor? = nil
    var toID :Int? = nil
    var titleText :String? = nil
    
    @IBAction func backAction(_ sender: Any) {
        self.dismissAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initVC(name: "VIEW_\(toID ?? 0)")
        self.titleLabel.hero.id = "TITLE_\(toID ?? 0)"
        
        self.titleLabel.text = titleText != nil ? titleText : ""
        
        self.view.backgroundColor = bgColor != nil ? bgColor : UIColor.black
        
        
        self.contentView.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            self.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.contentView.hero.modifiers = [.translate(y: UIScreen.main.bounds.height), .useGlobalCoordinateSpace]

        //self.preferredStatusBarStyle = UIStatusBarStyle.lightContent
        
        //AppConfig.init().lightStatusBar(animated: animated)
        //UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)


    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    


}
