import UIKit
import FirebaseAuth
import FBSDKLoginKit

class MainViewController: UIViewController {
    
    //@IBOutlet weak var mainView: UIView!
    let primaryColor :PrimaryColor = PrimaryColor()
    //@IBOutlet weak var iconImage: UIImageView!
    //@IBOutlet weak var langImage: UIImageView!
    //@IBOutlet weak var textTitle: UILabel!
    //@IBOutlet weak var langImageLeft: UIImageView!
    //@IBOutlet weak var menuCollectionView: UICollectionView!
    
    var collectionView :UICollectionView? = nil
    var collectionViewConstraint :Constraint? = nil
    var bottomViewConstraint :Constraint? = nil
    
    
    var bottomView :UIView? = nil
    var blurTitleView :UIVisualEffectView? = nil
    
    var blurInView :UIView? = nil
    var blurInViewConstraint :Constraint? = nil
    
    var labelTitle :UILabel? = nil
    var labelTitleConstraint :Constraint? = nil
    
    var appIconImageView :UIImageView? = nil
    var appIconImageViewConstraint :Constraint? = nil
    
    var langIconImageView :UIImageView? = nil
    var langIconImageViewConstraint :Constraint? = nil
    
    var cellWidth: CGFloat!
    var cellHeight :CGFloat!
    
    var lastPosition :Int? = nil
    
    var langCoreData :LangCoreData? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.hero.isEnabled = true
        
        self.langCoreData = LangCoreData()
        
        
        
        
        //print("UID : \(Auth.auth().currentUser?.uid)")
        //print("Name : \(Auth.auth().currentUser?.displayName)")
        
        
        
        /*
         if(UIDevice().isIpad()){
         textTitle.fontSize(size: 54)
         }else {
         textTitle.fontSize(size: 46)
         }
         */
        
        //print(UIDevice().isIpad())
        
        self.view.backgroundColor = UIColor.white
        //self.mainView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        //iconImage.setStyleImage(cornerRadius: 27)
        //langImage.setStyleImage(cornerRadius: 27)
        //langImageLeft.setStyleImage(cornerRadius: 27)
        
        /*menuCollectionView.dataSource = self
         menuCollectionView.delegate = self
         
         menuCollectionView.register(UINib.init(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCVC")
         */
        //menuCollectionView.isHidden = true
        //let cellReuseIdentifier = "collectionCell"
        
        
        let flowLayout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        
        
        
        //collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView!.register(UINib.init(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        //collectionView.register(UINib.init(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        collectionView!.showsHorizontalScrollIndicator = false
        collectionView!.showsVerticalScrollIndicator = false
        
        //self.view.addSubview(collectionView!)
        self.view.insertSubview(collectionView!, at: 0)
        
        //collectionView!.configConstraints()
        
        
        
        
        //print("Life Cycle : viewDidLoad")
        
        rotateBlur()
        
        rotateSafe()
        rotateLangAction()
        
        
        
        
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //UIView().onClick(tap: UITapGestureRecognizer(target: self, action: #selector(langImageTapped(_:))), view: appIconImageView!)
        
        
        /*let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
         layout.itemSize = CGSize(width: menuCollectionView.bounds.width - 40, height: 250)
         //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
         layout.scrollDirection = .vertical
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 0
         menuCollectionView.collectionViewLayout = layout
         */
        
        
        //print("Lang : \(langCoreData!.now())")
        
        //initLangIcon()

        
        
        
        
        
    }
    
    private func initLangIcon(){
        labelTitle?.hero.id = "AppName"
        if(langCoreData!.now() == LangCoreData.Language.Thai){
            langIconImageView?.image = #imageLiteral(resourceName: "ThaiFlagOn")
            labelTitle?.text = "เด็กสองภาษา"
            
        }else {
            langIconImageView?.image = #imageLiteral(resourceName: "EngFlagOn")
            labelTitle?.text = "Dek2Pasaa"

        }
        
        collectionView?.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        //print("Life Cycle : viewDidAppear")
        rotateBlur()
        
        rotateSafe()
        
        rotateLangAction()
    
        
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        //print("Life Cycle : didRotate")
        rotateBlur()
        
        rotateSafe()
        rotateLangAction()
        
    }
    
    func rotateBlur(){
        //blurTitleView = UIVisualEffectView(frame:CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        if(blurTitleView != nil){
            blurTitleView?.removeFromSuperview()
        }
        
        blurTitleView = UIVisualEffectView()
        blurTitleView?.frame = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: UIDevice.topSafeArea() + 64)
        //blurTitleView?.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        blurTitleView?.effect = UIBlurEffect(style: .light)
        
        self.view.addSubview(blurTitleView!)
        
        
        
        blurInView = UIView()
        //blurInView?.backgroundColor = UIColor.red
        blurInViewConstraint = blurInView?.setupConstraint()
        
        blurTitleView?.contentView.addSubview(blurInView!)
        
        
        blurInViewConstraint?.setup(type: Constraint.heightAnchor, actionTo: nil, value: 60)
        blurInViewConstraint?.setup(type: Constraint.bottomAnchor, actionTo: blurTitleView, value: 0)
        blurInViewConstraint?.setup(type: Constraint.leadingAnchor, actionTo: blurTitleView, value: 0)
        blurInViewConstraint?.setup(type: Constraint.trailingAnchor, actionTo: blurTitleView, value: 0)
        
        
        
        labelTitle = UILabel()
        labelTitle?.text = "ทดสอบ"
        //labelTitle?.backgroundColor = UIColor.blue
        labelTitle!.font = UIFont (name: "TS-SOM TUM-np", size: 52)
        labelTitle?.textColor = UIColor.darkText
        labelTitle!.center = (blurTitleView?.contentView.center)!
        
        
        labelTitleConstraint = labelTitle?.setupConstraint()
        
        blurInView?.addSubview(labelTitle!)
        
        
        
        
        if(appIconImageView != nil || langIconImageView != nil){
            appIconImageView = nil
            langIconImageView = nil
        }
        
        if(appIconImageView == nil || langIconImageView == nil){
            appIconImageView = UIImageView()
            appIconImageView?.setStyleImage(cornerRadius: 25)
            
            appIconImageView!.image = #imageLiteral(resourceName: "newIcon")
            appIconImageView?.backgroundColor = UIColor.clear
            appIconImageView?.contentMode = .scaleAspectFill
            
            appIconImageViewConstraint = appIconImageView?.setupConstraint()
            
            appIconImageView?.hero.id = "AppIcon"
            
            //blurInView?.backgroundColor = UIColor.red
            blurInView?.addSubview(appIconImageView!)
            
            
            langIconImageView = UIImageView()
            
            //langIconImageView!.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(langImageTapped(_:))))
            
            blurTitleView!.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(langImageTapped(_:))))
            
            
            langIconImageView?.setStyleImage(cornerRadius: 25)
            
            langIconImageView!.image = #imageLiteral(resourceName: "ThaiFlagOn")
            langIconImageView!.backgroundColor = UIColor.clear
            langIconImageView!.contentMode = .scaleAspectFill
            
            langIconImageViewConstraint = langIconImageView?.setupConstraint()
            
            blurInView?.addSubview(langIconImageView!)
        }
        
        appIconImageViewConstraint?.setup(type: Constraint.centerYAnchor, actionTo: blurInView, value: nil)
        appIconImageViewConstraint?.setup(type: Constraint.heightAnchor, actionTo: nil, value: 50)
        appIconImageViewConstraint?.setup(type: Constraint.widthAnchor, actionTo: nil, value: 50)
        
        langIconImageViewConstraint?.setup(type: Constraint.centerYAnchor, actionTo: blurInView, value: nil)
        langIconImageViewConstraint?.setup(type: Constraint.heightAnchor, actionTo: nil, value: 50)
        langIconImageViewConstraint?.setup(type: Constraint.widthAnchor, actionTo: nil, value: 50)
        
        if(UIDevice.init().isIpad()){
            appIconImageViewConstraint?.setup(type: Constraint.leadingAnchor, actionTo: blurInView, value: Int(UIDevice.leftSafeArea()) + 50)
            langIconImageViewConstraint?.setup(type: Constraint.trailingAnchor, actionTo: blurInView, value: Int(UIDevice.rightSafeArea()) + 50)
            
            
        }else {
            appIconImageViewConstraint?.setup(type: Constraint.leadingAnchor, actionTo: blurInView, value: Int(UIDevice.leftSafeArea()) + 20)
            langIconImageViewConstraint?.setup(type: Constraint.trailingAnchor, actionTo: blurInView, value: Int(UIDevice.rightSafeArea()) + 20)
            
        }
        
        
        
        
        
        
        
        
        if(!UIDevice.init().isIpad() && UIDevice.init().isLandscape()){
            labelTitle!.textAlignment = .left
            
            
            labelTitleConstraint?.setup(type: Constraint.centerXAnchor, actionTo: blurInView, value: nil)
            labelTitleConstraint?.setup(type: Constraint.centerYAnchor, actionTo: blurInView, value: nil)
            
            labelTitleConstraint?.setup(type: Constraint.leadingAnchor, actionTo: appIconImageView, value:  50 + 20)
            labelTitleConstraint?.setup(type: Constraint.trailingAnchor, actionTo: blurInView, value: 20)
            
        }else {
            labelTitle!.textAlignment = .center
            
            labelTitleConstraint?.setup(type: Constraint.centerXAnchor, actionTo: blurInView, value: nil)
            labelTitleConstraint?.setup(type: Constraint.centerYAnchor, actionTo: blurInView, value: nil)
            
            labelTitleConstraint?.setup(type: Constraint.leadingAnchor, actionTo: blurInView, value: 20)
            labelTitleConstraint?.setup(type: Constraint.trailingAnchor, actionTo: blurInView, value: 20)
            
        }
        
        
        
        
        
        
        /*
         if(blurTitleView != nil){
         blurTitleView?.removeFromSuperview()
         blurTitleView = nil
         }
         
         blurTitleView = UIVisualEffectView()
         blurTitleView?.frame = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: UIDevice.topSafeArea() + 64)
         //blurTitleView?.backgroundColor = UIColor.red.withAlphaComponent(0.4)
         blurTitleView?.effect = UIBlurEffect(style: .light)
         
         
         
         //blurTitleView?.backgroundColor = UIColor.blue
         self.view.addSubview(blurTitleView!)
         
         if(blurInViewConstraint == nil){
         blurInView = UIView()
         blurInView?.backgroundColor = UIColor.clear
         blurInViewConstraint = blurInView?.setupConstraint()
         }
         
         //blurTitleView?.contentView.addSubview(blurInView!)
         
         
         
         blurInViewConstraint?.setup(type: Constraint.heightAnchor, actionTo: nil, value: 60)
         blurInViewConstraint?.setup(type: Constraint.bottomAnchor, actionTo: blurTitleView, value: 0)
         blurInViewConstraint?.setup(type: Constraint.leadingAnchor, actionTo: blurTitleView, value: 0)
         blurInViewConstraint?.setup(type: Constraint.trailingAnchor, actionTo: blurTitleView, value: 0)
         
         
         if(labelTitleConstraint != nil){
         labelTitleConstraint = nil
         labelTitle?.removeFromSuperview()
         }
         
         labelTitle = UILabel()
         labelTitle?.text = "ทดสอบ"
         //labelTitle?.backgroundColor = UIColor.red
         labelTitle!.font = UIFont (name: "TS-SOM TUM-np", size: 52)
         labelTitle?.textColor = UIColor.darkText
         labelTitle!.textAlignment = .center
         labelTitle!.center = (blurTitleView?.contentView.center)!
         labelTitleConstraint = labelTitle?.setupConstraint()
         
         
         
         //labelTitleConstraint?.setup(type: Constraint.leadingAnchor, actionTo: blurInView, value: 50)
         //labelTitleConstraint?.setup(type: Constraint.trailingAnchor, actionTo: blurInView, value: 50)
         
         blurInView?.addSubview(labelTitle!)
         
         labelTitleConstraint?.setup(type: Constraint.centerXAnchor, actionTo: blurInView, value: nil)
         labelTitleConstraint?.setup(type: Constraint.centerYAnchor, actionTo: blurInView, value: nil)
         
         //labelTitleConstraint?.setup(type: Constraint.heightAnchor, actionTo: nil, value: 60)
         //labelTitleConstraint?.setup(type: Constraint.widthAnchor, actionTo: nil, value: 60)
         
         labelTitleConstraint?.setup(type: Constraint.leadingAnchor, actionTo: blurInView, value: 20)
         labelTitleConstraint?.setup(type: Constraint.trailingAnchor, actionTo: blurInView, value: 20)
         
         //print(UIDevice.bottomSafeArea())
         */
    }
    
    func rotateSafe() {
        //collectionView!.leadingAnchor(mainView: self.view, length: 0)
        //collectionView!.trailingAnchor(mainView: self.view, length: 0)
        //collectionView!.topAnchor(mainView: self.view, length:0)
        
        if(collectionViewConstraint != nil){
            collectionViewConstraint = nil
            //collectionViewConstraint = collectionView!.setupConstraint()
        }
        
        collectionViewConstraint = collectionView!.setupConstraint()
        
        
        collectionViewConstraint!.setup(type: Constraint.leadingAnchor, actionTo: self.view, value: 0)
        collectionViewConstraint!.setup(type: Constraint.trailingAnchor, actionTo: self.view, value: 0)
        
        //if(UIDevice.hasNotch()){
        if(UIDevice.hasNotch()){
            if(bottomView != nil){
                bottomView?.removeFromSuperview()
                bottomViewConstraint = nil
            }
            
            
            //bottomView = UIView(frame:CGRect(x: 0,y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50))
            bottomView = UIView()
            //bottomView!.backgroundColor = UIColor.red
            self.view.insertSubview(bottomView!, at: 0)
            bottomViewConstraint = bottomView!.setupConstraint()
            
        }
        
        
        if(!UIDevice().isIpad() && UIDevice().isLandscape()){
            //print("HELLO2")
            
            if(UIDevice.hasNotch()){
                //print("HELLO1")
                collectionViewConstraint!.setup(type: Constraint.bottomAnchor, actionTo: bottomView!, value: 0)
                collectionViewConstraint!.setup(type: Constraint.topAnchor, actionTo: bottomView!, value: 0)
            }else {
                
                //print(UIDevice.isNotch)
                collectionViewConstraint!.setup(type: Constraint.topAnchor, actionTo: self.view, value: 0)
                collectionViewConstraint!.setup(type: Constraint.bottomAnchor, actionTo: self.view, value: 0)
                
            }
            
        }else {
            
            if(UIDevice.hasNotch()){
                collectionViewConstraint!.setup(type: Constraint.bottomAnchor, actionTo: bottomView!, value: 0)
            }else {
                collectionViewConstraint!.setup(type: Constraint.bottomAnchor, actionTo: self.view, value: 0)
            }
            collectionViewConstraint!.setup(type: Constraint.topAnchor, actionTo: self.view, value: 0)
        }
        
        
        
        
        if(UIDevice.hasNotch()){
            
            //bottomView!.configConstraints()
            //bottomView!.leadingAnchor(mainView: self.view, length: 0)
            bottomViewConstraint!.setup(type: Constraint.leadingAnchor, actionTo: self.view, value: 0)
            //bottomView!.trailingAnchor(mainView: self.view, length: 0)
            bottomViewConstraint!.setup(type: Constraint.trailingAnchor, actionTo: self.view, value: 0)
            //bottomView!.topAnchor(mainView: self.view, length:0)
            //bottomView!.heightAnchor(length: 50)
            bottomViewConstraint!.setup(type: Constraint.heightAnchor, actionTo: nil, value: 50)
            
            //bottomView!.bottomAnchor(mainView: self.view, length: 0)
            bottomViewConstraint!.setup(type: Constraint.bottomAnchor, actionTo: self.view, value: 0)
            
            //collectionViewConstraint!.setup(type: Constraint.bottomAnchor, actionTo: bottomView!, value: 0)
            
            
            //collectionView!.bottomAnchor(mainView: bottomView!, length: 0)
            
            
            
        }else {
            //collectionViewConstraint!.setup(type: Constraint.bottomAnchor, actionTo: self.view, value: 0)
            //collectionView!.bottomAnchor(mainView: self.view, length: 0)
        }
        
        
    }
    
    
    
    func rotateLangAction(){
        
        initLangIcon()

        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        
        //collectionView!.layer.frame.size.width = UIScreen.main.bounds.width
        //collectionView!.layer.frame.size.height = UIScreen.main.bounds.height
        
        //print(UIDevice().isLandscape())
        
        //UIDevice().inspectDeviceOrientation()
        
        if(!UIDevice().isIpad() && UIDevice().isLandscape()){
            
            //langImageLeft.showWithAnimation(duration: 0.1)
            //print("1")
            if(UIDevice.hasNotch()){
                //collectionView!.layer.frame.size.height = UIScreen.main.bounds.height - ((bottomView!.bounds.height - 20) )
                //collectionView?.anchor(mainView: bottomView!, top: 0, bottom: 0, leading: 0, trailing: 0)
                
                //collectionView!.topAnchor(mainView: self.view, length:20)
                
                
                
                //collectionViewConstraint!.setup(type: Constraint.bottomAnchor, actionTo: bottomView!, value: 0)
                //collectionViewConstraint!.setup(type: Constraint.topAnchor, actionTo: bottomView!, value: 80)
                
                //collectionViewConstraint!.setup(type: Constraint.topAnchor, actionTo: bottomView!, value: 50)
                
                
                //collectionView?.backgroundColor = UIColor.blue
                //bottomView?.backgroundColor = UIColor.red
                
                
                layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10)
                layout.itemSize = CGSize(width: 220, height: collectionView!.bounds.height - 25 - 80)
                
                
                
                
                //collectionView!.backgroundColor = UIColor.blue
                //print("2")
                
                
                
            }else {
                //print("3")
                
                layout.sectionInset = UIEdgeInsets(top: 120, left: 10, bottom: 40, right: 10)
                layout.itemSize = CGSize(width: 220, height: collectionView!.bounds.height - 100)
            }
            
            //collectionView!.anchor(mainView: self.view, top: 20, bottom: 0, leading: 20, trailing: 20)
            
            //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }else if(!UIDevice().isIpad()) {
            //langImageLeft.hideWithAnimation(duration: 0.0)
            //print("4")
            
            layout.sectionInset = UIEdgeInsets(top: 100, left: 0, bottom: 40, right: 0)
            layout.itemSize = CGSize(width: collectionView!.bounds.width - 20, height: collectionView!.bounds.height * 0.6)
            //layout.itemSize = CGSize(width: collectionView!.bounds.width - 20, height: 500)
            //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 50
            layout.minimumLineSpacing = 10
        }else {
            
            //langImageLeft.hideWithAnimation(duration: 0.0)
            //print("5")
            
            let totalCellWidth = 80 * collectionView!.numberOfItems(inSection: 0)
            let totalSpacingWidth = 10 * (collectionView!.numberOfItems(inSection: 0) - 1)
            let leftInset = (collectionView!.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            
            if(UIDevice().isLandscape()){
                layout.sectionInset = UIEdgeInsets(top: 120, left: leftInset/5.5, bottom: 60, right: rightInset/5.5)
            }else {
                layout.sectionInset = UIEdgeInsets(top: 120, left: leftInset/3, bottom: 60, right: rightInset/3)
            }
            
            
            var width = collectionView!.bounds.width / 2.5
            //print(width)
            
            if(width > 300){
                width = 300
            }
            
            
            layout.itemSize = CGSize(width: width , height: 400)
            //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 30
        }
        
        layout.invalidateLayout()
        
        //print("rotate: \(layout.itemSize.width)")
        cellWidth = layout.itemSize.width - 32
        cellHeight = layout.itemSize.height
        
        
        collectionView!.collectionViewLayout = layout
        collectionView!.reloadData()
        //collectionView!.layoutIfNeeded()
        
        //menuCollectionView.collectionViewLayout = layout
        //menuCollectionView.reloadData()
        
    }
    
    func data() -> [MenuStruct] {
        
        return [
            
            MenuStruct(titleThai: "บทเรียน",titleEng: "Lessons", image: #imageLiteral(resourceName: "BookMenuIcon"),imageCover: #imageLiteral(resourceName: "BookMenu") ,color :primaryColor.colorRedDark,colorBg :primaryColor.color_game_red_dark),
            MenuStruct(titleThai: "แบบทดสอบ",titleEng: "Tests", image: #imageLiteral(resourceName: "Supplies"),imageCover: #imageLiteral(resourceName: "ExamMenu"),color :primaryColor.color_game_blue,colorBg :primaryColor.color_game_blue_dark),
            MenuStruct(titleThai: "แข่งขัน",titleEng: "Competition", image: #imageLiteral(resourceName: "Muscles"),imageCover: #imageLiteral(resourceName: "ChallengeMenu"),color :primaryColor.color_game_green,colorBg :primaryColor.color_game_green_dark),
            MenuStruct(titleThai: "ตั้งค่า",titleEng: "Settings", image: #imageLiteral(resourceName: "Setting"),imageCover: #imageLiteral(resourceName: "SettingsMenu"),color :primaryColor.color_game_black,colorBg :primaryColor.color_game_black_dark),
            
            
            //MenuStruct(imageBg: nil, title: "หมวดหมู่", image: #imageLiteral(resourceName: "bookshelf"),color :RGBTOCOLOR(red: 186, green: 50, blue: 50, alpha: 255),description :"อุปกรณ์การทดลองวิทยาศาสตร์",colorLabel :UIColor.white),
            //MenuStruct(imageBg: nil, title: "ประวัติ", image: #imageLiteral(resourceName: "history-clock-button"),color :RGBTOCOLOR(red: 74, green: 54, blue: 202, alpha: 255),description :"การค้นหา",colorLabel: UIColor.white)
            //MenuStruct(imageBg: #imageLiteral(resourceName: "menu_wall_1"), title: "สแกนอุปกรณ์", image: #imageLiteral(resourceName: "9"))
            
        ]
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //lastPosition = collectionView.
        //print(lastPosition)
    }
    
    /*
     override func viewWillLayoutSubviews() {
     super.viewWillLayoutSubviews()
     
     
     guard let flowLayout = collectionView!.collectionViewLayout as? UICollectionViewFlowLayout else {
     return
     }
     
     print("04")
     collectionView!.collectionViewLayout.invalidateLayout()
     
     
     
     //flowLayout.invalidateLayout()
     }
     */
    
    
    /*
     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
     super.viewWillTransition(to: size, with: coordinator)
     coordinator.animate(alongsideTransition: nil) { _ in
     //print("Hello")
     /*
     self.rotateBlur()
     
     self.rotateSafe()
     self.rotateLangAction()
     */
     
     }
     }
     */
    
}



extension MainViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "MenuCVC", for: indexPath) as! MenuCollectionViewCell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MenuCollectionViewCell
        
        //print(indexPath.row)
        
        //print(indexPath.row)
        let slot = data()[indexPath.row]
        
        cell.cellBgView.backgroundColor = slot.colorBg
        cell.cellBgInsideView.backgroundColor = slot.color
        
        
        if(langCoreData?.now() == LangCoreData.Language.Thai){
            cell.titleLabel.text = slot.titleThai

        }else {
            cell.titleLabel.text = slot.titleEng
            
        }
        
        
        //cell.titleBgBlur.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 16)
        
        //print(menuCollectionView.bounds.width)
        
        //print("IS IPAD : \(UIDevice.init().isIpad())")
        //print("IS Portrait : \(UIDevice.init().isPortrait())")
        
        
        if(UIDevice.init().isIpad()){
            if(UIDevice.init().isPortrait()){
                cell.titleLabel.fontSize(size: Int((collectionView.bounds.height / 10 )/1.7))
            }else {
                cell.titleLabel.fontSize(size: Int((collectionView.bounds.width / 10 )/1.8))
            }
        }else {
            if(UIDevice.init().isPortrait()){
                cell.titleLabel.fontSize(size: Int((collectionView.bounds.height / 10 )/1.3))
            }else {
                cell.titleLabel.fontSize(size: Int((collectionView.bounds.width / 10 )/2))
            }
        }
        
        //cell.titleLabel.fontSize(size: Int((collectionView.bounds.height / 10 )/1.3))
        
        
        cell.imageIcon.image = slot.image
        
        
        //cell.titleBgBlur.contentView.backgroundColor = UIColor.clear
        
        cell.coverImageView.image = slot.imageCover
        
        cell.cellBgView.hero.id = "VIEW_\(indexPath.row)"
        cell.titleLabel.hero.id = "TITLE_\(indexPath.row)"
        
        
        /*
         
         cell.iconImageViewConstraint?.setup(type: Constraint.heightAnchor, actionTo: nil, value: Int(cell.iconViewInside!.bounds.width * 0.50))
         cell.iconImageViewConstraint?.setup(type: Constraint.widthAnchor, actionTo: nil, value: Int(cell.iconViewInside!.bounds.width * 0.50) )
         cell.iconImageViewConstraint?.setup(type: Constraint.centerYAnchor, actionTo: cell.iconViewInside, value: nil)
         cell.iconImageViewConstraint?.setup(type: Constraint.centerXAnchor, actionTo: cell.iconViewInside, value: nil)
         
         */
        //cell.iconImageView!.image = slot.image
        
        //print("05")
        
        
        //cell.titleBgBlur.layer.cornerRadius = 16
        //cell.titleBgBlur.backgroundColor = UIColor.white
        
        //cell.titleBgBlur.newRoundCorners(corners: [.bottomLeft,.bottomRight], radius: 16)
        //cell.titleBgBlur.newRoundCorners(width: cellWidth, height: cellHeight, corners:  [.bottomLeft,.bottomRight], radius: 16)
        
        //cell.titleLabel.textColor = slot.colorBg
        
        
        //cell.titleBgBlurConstraint
        
        
        
        
        //cell.blurView.bounds.width = width
        //cell.blurView.bounds.height = height
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
            //showLoadingDialog()
            
            
            
            //let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().ScanViewController) as! ScanViewController
            //MainConfig().actionNavVC(this: self, viewController: vc)
            
            let vc = AppConfig.init().requireViewController(storyboard: CallCenter.init().MainStoryboard, viewController: CallCenter.init().GameViewController) as! GameViewController
            
            vc.bgColor = data()[indexPath.row].color
            vc.bgColorDark = data()[indexPath.row].colorBg
            vc.toID = indexPath.row
            vc.id = indexPath.row
            if(langCoreData?.now() == LangCoreData.Language.Thai){
                vc.titleText = data()[indexPath.row].titleThai

            }else {
                vc.titleText = data()[indexPath.row].titleEng
            }
            
            
            self.actionVC(this: self, viewController: vc)
            
            
            
            /*let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().DetailViewController) as! DetailViewController
             MainConfig().actionNavVC(this: self, viewController: vc)
             */
        }/*else if(indexPath.row == 1){
             let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().CategoryViewController) as! CategoryViewController
             MainConfig().actionVC(this: self, viewController: vc)
             
             }else if(indexPath.row == 2){
             let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().HistoryViewController) as! HistoryViewController
             MainConfig().actionVC(this: self, viewController: vc)
             
             }*/
        else {
            let vc = AppConfig.init().requireViewController(storyboard: CallCenter.init().MainStoryboard, viewController: CallCenter.init().SettingViewController) as! SettingViewController
            
            vc.bgColor = data()[indexPath.row].color
            vc.bgColorDark = data()[indexPath.row].colorBg
            vc.view.backgroundColor = vc.bgColorDark
            vc.toID = indexPath.row
            vc.titleLabel.hero.id = "TITLE_\(indexPath.row)"
            vc.view.hero.id = "TITLE_\(indexPath.row)"


            
            if(langCoreData?.now() == LangCoreData.Language.Thai){
                vc.titleLabel.text = data()[indexPath.row].titleThai
            }else {
                vc.titleLabel.text = data()[indexPath.row].titleEng
            }
            
            
            self.actionVC(this: self, viewController: vc)
            
        }
        
        
    }
    
    func showActionSheet(){
        
        var title = ""
        var message = ""
        var cancel = ""
        
        if(langCoreData?.now() == LangCoreData.Language.Thai){
            title = "ภาษา"
            message = "กรุณาเลือกภาษาที่คุณต้องการ"
            cancel = "ยกเลิก"
        }else {
            title = "Language"
            message = "Choose the language you want"
            cancel = "Cancel"
        }
        
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
        
        
        
        let thaiButton = UIAlertAction(title: "ภาษาไทย", style: .default, handler: { (action) -> Void in
            self.langCoreData?.update(lang: .Thai)
            self.initLangIcon()
        })
        
        let englishButton = UIAlertAction(title: "English", style: .default, handler: { (action) -> Void in
            self.langCoreData?.update(lang: .English)
            self.initLangIcon()
        })
        
        let cancelButton = UIAlertAction(title: cancel, style: .cancel, handler: { (action) -> Void in
        })
        
        alertController!.addAction(thaiButton)
        alertController!.addAction(englishButton)
        alertController!.addAction(cancelButton)
        
        
        
        self.present(alertController!, animated: true, completion: nil)
    }
    
    @objc func langImageTapped(_ sender:UITapGestureRecognizer?){
        //print("TAPPED")
        showActionSheet()
    }
    
    
    
    
    
}
