import UIKit

extension UIViewController {

    func actionVC(this :UIViewController , viewController :UIViewController){
        viewController.isHeroEnabled = true
        viewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        viewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        this.present(viewController,animated: true,completion: nil)
    }

    func actionVCWithOutHero(this :UIViewController , viewController :UIViewController){
        this.present(viewController,animated: true,completion: nil)
    }

    func actionNavVC(this :UIViewController , viewController :UIViewController){
        viewController.isHeroEnabled = true
        
        let aObjNavi = UINavigationController(rootViewController: viewController)
        aObjNavi.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        aObjNavi.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        this.present(aObjNavi,animated: true,completion: nil)
    }

    func setFormSheet(){
        modalPresentationStyle = UIModalPresentationStyle.formSheet
        modalTransitionStyle = UIModalTransitionStyle.coverVertical
    }

    func actionNavVCWithOutHero(this :UIViewController , viewController :UIViewController){
        let aObjNavi = UINavigationController(rootViewController: viewController)
        aObjNavi.modalPresentationStyle = UIModalPresentationStyle.formSheet
        aObjNavi.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        
        this.present(aObjNavi,animated: true,completion: nil)
    }


    func initVC(){
        hero.isEnabled = true
        view.hero.id = "VIEW"
    }
    
    func initVC(name :String){
        hero.isEnabled = true
        view.hero.id = name.uppercased()
    }
    
    func dismissAction(){
        dismiss(animated: true, completion: nil)
    }
    
    func alert(title :String?,message :String) {
        let alert = UIAlertController(title: title != nil ? title! : "Alert", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }

}
