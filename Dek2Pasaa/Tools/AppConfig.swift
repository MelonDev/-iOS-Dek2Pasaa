import Foundation
import UIKit
import Hero

class AppConfig {
    
    func requireViewController(storyboard :String,viewController :String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: viewController)
        
        return vc
    }
    
    func lightStatusBar(animated: Bool){
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)
        
    }
    
    func darkStatusBar(animated: Bool){
        UIApplication.shared.setStatusBarStyle(.default, animated: animated)
    }
    
}

