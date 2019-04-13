
import UIKit
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController ,GIDSignInUIDelegate,GIDSignInDelegate{
    
    var loadingAlert :UIAlertController? = nil
    let alert = UIAlertController(title: nil, message: "กรุณารอสักครู่...", preferredStyle: .alert)

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if(error != nil){
            showErrorAlert(title: "Alert", message: error.localizedDescription)
            //print(error.localizedDescription)
        }else {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if error != nil {

                    self.showErrorAlert()
                    return
                }else {

                    self.showAlert()
                    
                }
            }
        }
        
    }
    
    func facebookLogin() {
        //self.showLoadingAlert()

        let LoginManager = FBSDKLoginManager()
        LoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            //self.hideLoadingAlert()
            if error != nil {
                self.showErrorAlert(title: "Failed to login", message: error!.localizedDescription)
                return
            } else if result!.isCancelled {
                self.showErrorAlert(title: "Cancelled", message: "ยกเลิกเรียบร้อย")
            } else {
                guard let accessToken = FBSDKAccessToken.current() else {
                    self.showErrorAlert(message: "Failed to get access token")
                    return
                }
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
                    if error != nil {
                        self.showErrorAlert(title: "Login error", message: error!.localizedDescription)
                        
                        return
                    }else {
                        self.showAlert()
                    }
                    // self.performSegue(withIdentifier: self.signInSegue, sender: nil)
                }
            }
        }
    }
    
    func goToMain(){
        //print("Hello")
        let vc = AppConfig.init().requireViewController(storyboard: CallCenter.init().MainStoryboard, viewController: CallCenter.init().MainViewController) as! MainViewController
        
        
        self.actionVC(this: self, viewController: vc)
        //self.dismissAction()
    }
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginBtn: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        hero.isEnabled = true

        
        //loginView.setStyle()
        loginView.layer.cornerRadius = 16
        loginBtn.layer.cornerRadius = 30
        loginBtn.backgroundColor = UIColor.init(rgb: 0x77523A)
        
        self.view.backgroundColor = PrimaryColor().splashColer
        
        // super.viewDidLoad()
        if(Auth.auth().currentUser != nil){
            goToMain()
        }else {
            
            loginBtn!.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(login(_:))))
            
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().delegate = self
            
        }
        
        
        
        //GIDSignIn.sharedInstance().signIn()
        
        
        
        //alert(title: nil, message: "Hello")
        
        
        /* let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)
         
         alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
         alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
         
         self.present(alert, animated: true)
         */
        
        //signOut()
        
        //let email = Auth.auth().currentUser?.email
        //print(email)
        
        /*
         if Auth.auth().currentUser != nil {
         print("PASS")
         }else {
         print("FAIL")
         }
         */
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //self.loginView.hero.modifiers = [.translate(y: UIScreen.main.bounds.height), .useGlobalCoordinateSpace]
        
        /*
         if(Auth.auth().currentUser != nil){
         goToMain()
         }else {
         loginView!.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(login(_:))))
         
         GIDSignIn.sharedInstance().uiDelegate = self
         GIDSignIn.sharedInstance().delegate = self
         }
         */
        
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Successful", message: "ลงชื่อเข้าใช้เรียบร้อย", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            //GIDSignIn.sharedInstance().signIn()
            self.goToMain()
            
        }))
        //alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func showErrorAlert(title :String = "Error",message :String = "เกิดข้อผิดพลาด"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) -> Void in
            //GIDSignIn.sharedInstance().signIn()
            //self.goToMain()
            
        }))
        //alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @objc func login(_ sender:UITapGestureRecognizer?){
        //print("TAPPED")
        showActionSheet()
    }
    
    func showActionSheet(){
        
        let title = "Login"
        let message = "กรุณาเลือกรูปแบบการลงชื่อเข้าใช้งาน"
        let cancel = "ยกเลิก"
        
        var alertController :UIAlertController? = nil
        
        if(UIDevice().isIpad()){
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            
        }else {
            alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
        }
        
        
        /*
         let sendButton = UIAlertAction(title: "Send now", style: .default, handler: { (action) -> Void in
         
         })
         
         let  deleteButton = UIAlertAction(title: "Delete forever", style: .destructive, handler: { (action) -> Void in
         print("Delete button tapped")
         })
         
         let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
         print("Cancel button tapped")
         })
         */
        
        
        
        let googleButton = UIAlertAction(title: "Google", style: .default, handler: { (action) -> Void in
            //GIDSignIn.sharedInstance().signIn()
            
            GIDSignIn.sharedInstance().signIn()
            
            
            
        })
        
        let facebookButton = UIAlertAction(title: "Facebook", style: .default, handler: { (action) -> Void in
            self.facebookLogin()
        })
        
        let cancelButton = UIAlertAction(title: cancel, style: .cancel, handler: { (action) -> Void in
        })
        
        alertController!.addAction(googleButton)
        alertController!.addAction(facebookButton)
        alertController!.addAction(cancelButton)
        
        
        
        self.present(alertController!, animated: true, completion: nil)
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func showLoadingAlert() {
        
        loadingAlert = UIAlertController(title: "Updating data", message: "Please wait...", preferredStyle: .alert)
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
    
    func hideLoadingDialog() {
        alert.dismissAction()
    }
    
    func showLoadingDialog() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    /*
     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
     
     //print(error?.localizedDescription)
     print("LOAD GOOGLE")
     
     
     if error != nil {
     print("ERROR 1")
     return
     }
     
     guard let authentication = user.authentication else { return }
     let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
     accessToken: authentication.accessToken)
     Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
     if error != nil {
     print("ERROR 2")
     return
     }
     
     }
     
     
     }*/
    
    
}