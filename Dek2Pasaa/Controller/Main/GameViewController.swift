

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var bgColor :UIColor? = nil
    var toID :Int? = nil
    var titleText :String? = nil
    
    var langCoreData :LangCoreData? = nil
    
    @IBAction func backAction(_ sender: Any) {
        self.dismissAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.langCoreData = LangCoreData()
        initBackBtn()
        

        
        self.initVC(name: "VIEW_\(toID ?? 0)")
        self.titleLabel.hero.id = "TITLE_\(toID ?? 0)"
        
        self.titleLabel.text = titleText != nil ? titleText : ""
        
        self.view.backgroundColor = bgColor != nil ? bgColor : UIColor.black
        
        
        backView.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(backActions(_:))))
        
        self.contentView.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            self.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        initBackBtn()
    }
    
    private func initBackBtn(){
        print("LANGGGGGGGGGGGG : \(langCoreData?.now())")
        if(langCoreData!.now() == LangCoreData.Language.Thai){
            //self.backBtn.titleLabel?.text = "ย้อนกลับ"
            backBtn.setTitle("ย้อนกลับ", for: .normal)

        }else {
            //self.backBtn.titleLabel?.text = "BACK"
            backBtn.setTitle("BACK", for: .normal)

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.contentView.hero.modifiers = [.translate(y: UIScreen.main.bounds.height), .useGlobalCoordinateSpace]
        //initBackBtn()

       
        //self.preferredStatusBarStyle = UIStatusBarStyle.lightContent
        
        //AppConfig.init().lightStatusBar(animated: animated)
        //UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)


    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func backActions(_ sender:UITapGestureRecognizer?){
        //print("TAPPED")
        self.dismissAction()
    }
    


}
