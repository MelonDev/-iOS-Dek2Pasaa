import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    let primaryColor :PrimaryColor = PrimaryColor()
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var langImage: UIImageView!
    @IBOutlet weak var textTitle: UILabel!
    @IBOutlet weak var langImageLeft: UIImageView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateLangAction()
        
        self.hero.isEnabled = true

        
        if(UIDevice().isIpad()){
            textTitle.fontSize(size: 54)
        }else {
            textTitle.fontSize(size: 46)
        }
        
        //print(UIDevice().isIpad())
        
        self.view.backgroundColor = UIColor.white
        self.mainView.backgroundColor = UIColor.white
        
        iconImage.setStyleImage(cornerRadius: 27)
        langImage.setStyleImage(cornerRadius: 27)
        langImageLeft.setStyleImage(cornerRadius: 27)
        
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        
        menuCollectionView.register(UINib.init(nibName: "MenuCVCell", bundle: nil), forCellWithReuseIdentifier: "MenuCVC")
        
        self.automaticallyAdjustsScrollViewInsets = false

        
        
        /*let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: menuCollectionView.bounds.width - 40, height: 250)
        //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        menuCollectionView.collectionViewLayout = layout
*/
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        rotateLangAction()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        rotateLangAction()
        
        
    }
    
    
    
    func rotateLangAction(){
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        if(!UIDevice().isIpad() && UIDevice().isLandscape()){
        
            langImageLeft.showWithAnimation(duration: 0.1)
            
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
            layout.itemSize = CGSize(width: 220, height: menuCollectionView.bounds.height - 20)
            //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }else if(!UIDevice().isIpad()) {
            langImageLeft.hideWithAnimation(duration: 0.0)
            
            layout.sectionInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
            layout.itemSize = CGSize(width: menuCollectionView.bounds.width - 20, height: 400)
            //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 50
            layout.minimumLineSpacing = 10
        }else {
            
            langImageLeft.hideWithAnimation(duration: 0.0)
            
            let totalCellWidth = 80 * menuCollectionView.numberOfItems(inSection: 0)
            let totalSpacingWidth = 10 * (menuCollectionView.numberOfItems(inSection: 0) - 1)
            let leftInset = (menuCollectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            
            if(UIDevice().isLandscape()){
                layout.sectionInset = UIEdgeInsets(top: 40, left: leftInset/5.5, bottom: 40, right: rightInset/5.5)
            }else {
                layout.sectionInset = UIEdgeInsets(top: 40, left: leftInset/3, bottom: 40, right: rightInset/3)
            }
            
            
            var width = menuCollectionView.bounds.width / 2.5
            //print(width)
            
            if(width > 300){
                width = 300
            }
            
            
            layout.itemSize = CGSize(width: width , height: 400)
            //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 10
        }
        
        layout.invalidateLayout()
        menuCollectionView.collectionViewLayout = layout
        menuCollectionView.reloadData()
    

    }
    
    func data() -> [MenuStruct] {
        
        return [

            MenuStruct(title: "บทเรียน", image: nil,color :primaryColor.colorRedDark,colorBg :primaryColor.color_game_red_dark),
            MenuStruct(title: "แบบทดสอบ", image: nil,color :primaryColor.color_game_blue,colorBg :primaryColor.color_game_blue_dark),
            MenuStruct(title: "แข่งขัน", image: nil,color :primaryColor.color_game_green,colorBg :primaryColor.color_game_green_dark),
            MenuStruct(title: "ตั้งค่า", image: nil,color :primaryColor.color_game_black,colorBg :primaryColor.color_game_black_dark),
            

            //MenuStruct(imageBg: nil, title: "หมวดหมู่", image: #imageLiteral(resourceName: "bookshelf"),color :RGBTOCOLOR(red: 186, green: 50, blue: 50, alpha: 255),description :"อุปกรณ์การทดลองวิทยาศาสตร์",colorLabel :UIColor.white),
            //MenuStruct(imageBg: nil, title: "ประวัติ", image: #imageLiteral(resourceName: "history-clock-button"),color :RGBTOCOLOR(red: 74, green: 54, blue: 202, alpha: 255),description :"การค้นหา",colorLabel: UIColor.white)
            //MenuStruct(imageBg: #imageLiteral(resourceName: "menu_wall_1"), title: "สแกนอุปกรณ์", image: #imageLiteral(resourceName: "9"))
            
        ]
        
    }

}

extension MainViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "MenuCVC", for: indexPath) as! MenuCVCell
        
        let slot = data()[indexPath.row]
        
        cell.cellBgView.backgroundColor = slot.colorBg
        cell.cellBgInsideView.backgroundColor = slot.color
        
        cell.cellTitleLabel.text = slot.title

        print(menuCollectionView.bounds.width)
        
        if(UIDevice.init().isIpad()){
            if(UIDevice.init().isPortrait()){
                cell.cellTitleLabel.fontSize(size: Int((menuCollectionView.bounds.height / 10 )/1.7))
            }else {
                cell.cellTitleLabel.fontSize(size: Int((menuCollectionView.bounds.width / 10 )/1.8))
            }
        }else {
            if(UIDevice.init().isPortrait()){
                cell.cellTitleLabel.fontSize(size: Int((menuCollectionView.bounds.height / 10 )/1.2))
            }else {
                cell.cellTitleLabel.fontSize(size: Int((menuCollectionView.bounds.width / 10 )/1.7))
            }
        }
        
        

        return cell
    }
 
 
    
}
