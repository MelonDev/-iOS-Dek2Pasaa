

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class SettingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    var loadingAlert :UIAlertController? = nil
    var imagePicker: UIImagePickerController? = nil

    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var bgColor :UIColor? = nil
    var bgColorDark :UIColor? = nil
    
    var toID :Int? = nil
    
    var langCoreData :LangCoreData? = nil
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismissAction()
    }
    
    struct StringLang {
        var thai :String
        var eng :String
    }
    
    func data() -> [StringLang] {
        
        return [StringLang.init(thai: "เปลี่ยนรูปภาพประจำตัว", eng: "Change image profile")
            ,StringLang.init(thai: "เปลี่ยนชื่อผู้ใช้", eng: "Change user name")
            //,StringLang.init(thai: "ติดต่อผู้ดูแล", eng: "Contact the admin")
            ,StringLang.init(thai: "ขอบคุณด้วยใจ", eng: "Acknowledgement")
            ,StringLang.init(thai: "ลงชื่อออก", eng: "Sign out")]
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        self.langCoreData = LangCoreData()
        
        
        self.initVC()
        initBackBtn()
        
        self.imagePicker = UIImagePickerController.init()
        imagePicker?.delegate = self

        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let windowHeight : CGFloat = 30
        let windowWidth  : CGFloat = 30
        
        let header = UIView()
        header.backgroundColor = UIColor.clear
        header.frame = CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight)
        
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        footer.frame = CGRect(x: 0, y: 0, width: windowWidth, height: 90)
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
        
        self.tableView.rowHeight = 90
        
        //titleLabel.hero.id = "TITLE_\(toID!)"
        //self.view.hero.id = "VIEW_\(toID!)"
        
        
        backBtnView.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(backActions(_:))))
        
    }
    
    private func initBackBtn(){
        //print("LANGGGGGGGGGGGG : \(langCoreData?.now())")
        if(langCoreData!.now() == LangCoreData.Language.Thai){
            //self.backBtn.titleLabel?.text = "ย้อนกลับ"
            backButton.setTitle("ย้อนกลับ", for: .normal)
            
        }else {
            //self.backBtn.titleLabel?.text = "BACK"
            backButton.setTitle("BACK", for: .normal)
            
        }
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
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingTableViewCell", for: indexPath) as! SettingTableViewCell
        
        if indexPath.row == data().count - 1 {
            cell.subContentView.backgroundColor = PrimaryColor().color_game_red
            
        }else {
            cell.subContentView.backgroundColor = bgColor
            
        }
        
        if(langCoreData!.now() == LangCoreData.Language.Thai){
            cell.titleLabel.text = data()[indexPath.row].thai

        }else {
            cell.titleLabel.text = data()[indexPath.row].eng

        }
        
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        //selectedCell.contentView.backgroundColor = UIColor.clear
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            self.imagePicker!.allowsEditing = false
            self.imagePicker!.sourceType = .photoLibrary
            
            present(self.imagePicker!, animated: true, completion: nil)
        case 1:
            if(langCoreData!.now() == LangCoreData.Language.Thai){
                showDialog(title: "เปลี่ยนชื่อผู้ใช้", message: "กรุณาพิมพ์ชื่อที่ต้องการแล้วกดยืนยันเพื่อบันทึกชื่อ", positiveString: "ยืนยัน", negativeString: "ยกเลิก", textFieldString: "ชื่อ", completion: {
                })
            }else {
                showDialog(title: "Change user name", message: "Please type the name you want and press confirm to save the name", positiveString: "Confirm", negativeString: "Cancel", textFieldString: "Name", completion: {
                    
                })
            }
        case 20:
            
            let id = "LanguageandApplication"
            if let url = URL(string: "fb-messenger://user-thread/\(id)") {
                
                // Attempt to open in Messenger App first
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in
                    
                    if success == false {
                        // Messenger is not installed. Open in browser instead.
                        let url = URL(string: "https://m.me/\(id)")
                        if UIApplication.shared.canOpenURL(url!) {
                            UIApplication.shared.open(url!)
                        }
                    }
                })
            }
            
        case 2:
            let vc = AppConfig.init().requireViewController(storyboard: CallCenter.init().MainStoryboard, viewController: CallCenter.init().AboutViewController) as! AboutViewController
            
            vc.bgColor = bgColor
            vc.bgColorDark = bgColorDark
            vc.view.backgroundColor = vc.bgColorDark
            
            self.actionVC(this: self, viewController: vc)
            
        case 3:
            if(langCoreData!.now() == LangCoreData.Language.Thai){
                showDialog(title: "ยืนยันการลงชื่อออก", message: "ท่านต้องการลงชื่อออกจากระบบใช่หรือไม่?", positiveString: "ยืนยัน", negativeString: "ยกเลิก", completion: {
                    do {
                        try Auth.auth().signOut()
                        try GIDSignIn.sharedInstance().signOut()
                        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
                        
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    } catch {
                        print("ERROR")
                    }
                })
            }else {
                showDialog(title: "Confirm sign out", message: "Do you want to sign out from the system?", positiveString: "Confirm", negativeString: "Cancel", completion: {
                    do {
                        try Auth.auth().signOut()
                        try GIDSignIn.sharedInstance().signOut()
                        
                        let vc = AppConfig.init().requireViewController(storyboard: CallCenter.init().MainStoryboard, viewController: CallCenter.init().LoginViewController) as! LoginViewController
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = vc
                        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
                        
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    } catch {
                        print("ERROR")
                    }
                })
                
            }
            
            
            
        default:
            print("ERROR")
        }
        
    }
    
    func showDialog(title :String,message :String?,positiveString :String,negativeString :String? = nil,textFieldString :String? = nil,completion :@escaping () -> Void){
        print(title)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionPositive = UIAlertAction(title: positiveString, style: .default, handler: { (action) -> Void in
            
            
            if textFieldString != nil {
                let text = (alert.textFields![0] as UITextField).text ?? ""
                alert.dismissAction()
                
                if text.count > 0 {
                    
                
                self.showLoadingAlert()
                let ref = Database.database().reference().child("Peoples").child(Auth.auth().currentUser!.uid).child("Info").child("name")
                
                ref.setValue(text, withCompletionBlock: {error,_ in
                    self.hideLoadingAlert()

                    if error == nil {
                        if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                            self.showDialog(title: "เปลี่ยนชื่อเรียบร้อย", message: "", positiveString: "OK", completion: {})
                        }else {
                            self.showDialog(title: "Change name successfully", message: "", positiveString: "Close", completion: {})
                        }
                    }else {
                        if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                            self.showDialog(title: "เกิดข้อผิดพลาด", message: "กรุณาเชื่อมต่ออินเทอร์เน็ต", positiveString: "รับทราบ", completion: {})
                        }else {
                            self.showDialog(title: "Error", message: "Please connect to the internet", positiveString: "Close", completion: {})
                        }
                        
                    }
                })
                }else {
                    if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                        self.showDialog(title: "เกิดข้อผิดพลาด", message: "กรุณาใส่ข้อมูล", positiveString: "รับทราบ", completion: {})
                    }else {
                        self.showDialog(title: "Error", message: "Please enter name", positiveString: "Close", completion: {})
                    }
                }
               
            }else {
                alert.dismissAction()
            completion()
            }
        })
        
        if negativeString != nil {
            let actionNegative = UIAlertAction(title: negativeString, style: .cancel, handler: { (action) -> Void in
                alert.dismissAction()
            })
            alert.addAction(actionNegative)
            
            
        }
        
        if textFieldString != nil {
            alert.addTextField { (textField) in
                //textField.text = textFieldString
            }
        }
        
        alert.addAction(actionPositive)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showLoadingAlert() {
        //print("asfjwaefijdfgsdafgk,")
        
        loadingAlert = UIAlertController(title: nil , message:"Setting data...", preferredStyle: .alert)
        
        if(LangCoreData().now() == LangCoreData.Language.Thai){
            loadingAlert?.message = "กำลังตั้งค่าข้อมูล.."
            //loadingAlert = UIAlertController(title: nil , message:"กำลังโหลดข้อมูล", preferredStyle: .alert)
        }else {
            loadingAlert?.message = "Loading.."
            
        }
        
        
        loadingAlert!.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10,y: 5,width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        loadingAlert!.view.addSubview(loadingIndicator)
        self.present(loadingAlert!, animated: true)
        
    }
    
    func hideLoadingAlert() {
        
        loadingAlert?.dismissAction()
        
    }

    
}

extension SettingViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let storageRef = Storage.storage().reference().child("User").child("\(Auth.auth().currentUser!.uid).jpeg")
            let imgData = pickedImage.jpegData(compressionQuality: 0.8)
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            DispatchQueue.main.async {
                self.showLoadingAlert()
            }
            
            storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
                if error == nil{
                    storageRef.downloadURL(completion: { (url, error) in
                        let ref = Database.database().reference().child("Peoples").child(Auth.auth().currentUser!.uid).child("Info").child("image")
                        
                        ref.setValue(url!.absoluteString, withCompletionBlock: {error,_ in
                            
                            if error == nil{
                                self.hideLoadingAlert()
                                if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                                    self.showDialog(title: "อัปโหลดรูปเรียบร้อย", message: "", positiveString: "OK", completion: {})
                                }else {
                                    self.showDialog(title: "Upload photo successfully", message: "", positiveString: "Close", completion: {})
                                }
                            }else {
                                self.hideLoadingAlert()
                                if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                                    self.showDialog(title: "เกิดข้อผิดพลาด", message: "กรุณาเชื่อมต่ออินเทอร์เน็ต", positiveString: "รับทราบ", completion: {})
                                }else {
                                    self.showDialog(title: "Error", message: "Please connect to the internet", positiveString: "Close", completion: {})
                                }
                            }
                            
                        })
                    })
                }else{
                    self.hideLoadingAlert()
                    if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                        self.showDialog(title: "เกิดข้อผิดพลาด", message: "กรุณาเชื่อมต่ออินเทอร์เน็ต", positiveString: "รับทราบ", completion: {})
                    }else {
                        self.showDialog(title: "Error", message: "Please connect to the internet", positiveString: "Close", completion: {})
                    }
                    
                }
            }
        
        
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
