import UIKit

extension UIViewController {

    func actionVC(this :UIViewController , viewController :UIViewController){
        viewController.isHeroEnabled = true
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
    
    func dismissAction(){
        dismiss(animated: true, completion: nil)
    }

}
