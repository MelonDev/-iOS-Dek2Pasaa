

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismissAction()

    }
    @IBOutlet weak var contentLabel: UILabel!
    
    var bgColor :UIColor? = nil
    var bgColorDark :UIColor? = nil
    
    var langCoreData :LangCoreData? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.langCoreData = LangCoreData()
        
        
        self.initVC()
        initBackBtn()
        
         backView.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(backActions(_:))))
        
        if(langCoreData!.now() == LangCoreData.Language.Thai){
            //self.backBtn.titleLabel?.text = "ย้อนกลับ"
            contentLabel.text = "- ทีมภาษาดี\n- นายชัยวิวัฒน์ กกสันเทียะ\n- อุทยานวิทยาศาสตร์ มหาวิทยาลัยพะเยา\n- กระทรวงวิทยาศาสตร์ และ เทคโนโลยี"
            titleLabel.text = "ขอบคุณด้วยใจ"
            
        }else {
            //self.backBtn.titleLabel?.text = "BACK"
            contentLabel.text = "- Pasaa-d.com and Team\n- Chaiwiwat Koksantia\n- University of Phayao Science Park (UPSP)\n- TED FUND, Ministry of Science and Technology"
            titleLabel.text = "Acknowledgement"

            
        }
        
        
    }
    
    private func initBackBtn(){
        //print("LANGGGGGGGGGGGG : \(langCoreData?.now())")
        if(langCoreData!.now() == LangCoreData.Language.Thai){
            //self.backBtn.titleLabel?.text = "ย้อนกลับ"
            backBtn.setTitle("ย้อนกลับ", for: .normal)
            
        }else {
            //self.backBtn.titleLabel?.text = "BACK"
            backBtn.setTitle("BACK", for: .normal)
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc func backActions(_ sender:UITapGestureRecognizer?){
        //print("TAPPED")
        self.dismissAction()
    }
 

}
