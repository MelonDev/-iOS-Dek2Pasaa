

import UIKit
import Firebase
import Alamofire
import AlamofireImage

class GameViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var loadingAlert :UIAlertController? = nil
    
    var id :Int? = nil
    
    var bgColor :UIColor? = nil
    var bgColorDark :UIColor? = nil
    var toID :Int? = nil
    var titleText :String? = nil
    
    var score :Int? = nil
    
    var hideScore = false
    
    var isInitCollectionView = false
    var lessonKey :String? = nil
    
    
    var langCoreData :LangCoreData? = nil
    
    var data :[LessonInfo] = []
    var dataWord :[WordInfo] = []
    var dataTest :[TestInfo] = []
    var dataCheck :[String :TestCheck] = [:]
    
    
    var dataCache :[Int :Image] = [:]
    
    @IBAction func backAction(_ sender: Any) {
        self.dismissAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.langCoreData = LangCoreData()
        initBackBtn()
        
        
        self.scoreView.layer.cornerRadius = self.scoreView.bounds.height / 2
        if #available(iOS 11.0, *) {
            self.scoreView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        self.scoreView.backgroundColor = bgColor
        self.scoreLabel.text = ""
        self.scoreView.isHidden = true
        
        
        
        setUpCollectionView()
        isInitCollectionView = true
        loadFirebase()
        
        
        
        
        
        if(UIDevice().isIpad()){
            self.backBtn.isHidden = false
            loadScore()
        }else {
            if(UIDevice().isLandscape()){
                self.backBtn.isHidden = false
                loadScore()
            }else {
                self.backBtn.isHidden = true
                if(!hideScore){
                    loadScore()
                }
            }
        }
        //self.backBtn.isHidden = hideScore
        
        
        self.initVC(name: "VIEW_\(toID ?? 0)")
        self.titleLabel.hero.id = "TITLE_\(toID ?? 0)"
        
        self.titleLabel.text = titleText != nil ? titleText : ""
        
        self.view.backgroundColor = bgColorDark != nil ? bgColorDark : UIColor.black
        
        self.contentView.backgroundColor = bgColor != nil ? bgColor : UIColor.black
        
        
        backView.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(backActions(_:))))
        
        self.contentView.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            self.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        
        
    }
    
    func loadScore() {
        let ref = Database.database().reference()
        
        let uid = Auth.auth().currentUser!.uid
        //let uid = "FyDDLisKFcgAifEAXbuILau40cC2"
        
        ref.child("Peoples").child(uid).child("History").observe(.value, with: {(snapshot) in
            //self.stopLoadingDialog()
            self.score = 0
            
            if(snapshot.hasChildren()){
                
                
                for slot in snapshot.children {
                    
                    let slotDS = slot as! DataSnapshot
                    
                    if(slotDS.hasChildren()){
                        for subSlot in slotDS.children {
                            let subSlotDS = subSlot as! DataSnapshot
                            
                            let value = subSlotDS.value as! [String: AnyObject]
                            
                            let failed = value["failed"] as! Bool
                            let opened = value["opened"] as! Bool
                            let passed = value["passed"] as! Bool
                            
                            if !failed && opened && passed {
                                self.score! += 1
                            }
                            
                            
                            
                            
                            
                            //print(subSlotDS.key)
                            
                        }
                    }
                    
                    
                    /*let lessonDataSnapshot = lesson as! DataSnapshot
                     
                     let value = LessonInfo.init(slot: (lessonDataSnapshot.childSnapshot(forPath: "Info").value as! [String: AnyObject]))
                     
                     if !value.delete {
                     self.data.append(value)
                     }
                     */
                    
                    
                    
                }
                
                //print(self.score)
                
                
                
            }
            
            self.scoreView.isHidden = false
            if(LangCoreData().now() == LangCoreData.Language.Thai){
                self.scoreLabel.text = "\(self.score ?? 0) คะแนน"
                
            }else {
                self.scoreLabel.text = "Score: \(self.score ?? 0)"
            }
        })
    }
    
    func showLoadingAlert() {
        //print("asfjwaefijdfgsdafgk,")
        
        loadingAlert = UIAlertController(title: "TEST" , message:"Loading", preferredStyle: .alert)
        
        
        if(LangCoreData().now() == LangCoreData.Language.Thai){
            loadingAlert?.message = "กำลังโหลดข้อมูล"
            //loadingAlert = UIAlertController(title: nil , message:"กำลังโหลดข้อมูล", preferredStyle: .alert)
        }else {
            loadingAlert?.message = "Loading"
            
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
    
    func loadFirebase() {
        
        //showLoadingAlert()
        
        let ref = Database.database().reference()
        //self.showLoadingDialog()
        
        self.indicator.isHidden = false
        
        
        if self.id! == 0 || self.id! == 1 {
            
            
            
            ref.child("Lessons").observe(.value, with: {(snapshot) in
                //self.stopLoadingDialog()
                
                self.data.removeAll()
                
                if(snapshot.hasChildren()){
                    
                    for lesson in snapshot.children {
                        let lessonDataSnapshot = lesson as! DataSnapshot
                        
                        //let value = lessonDataSnapshot.childSnapshot(forPath: "Info").childSnapshot(forPath: "nameEng").value as! String
                        
                        let value = LessonInfo.init(slot: (lessonDataSnapshot.childSnapshot(forPath: "Info").value as! [String: AnyObject]))
                        
                        if !value.delete {
                            self.data.append(value)
                        }
                        
                        
                    }
                    
                    self.data.sorted(by: { $0.number < $1.number })
                    
                    self.collectionView.reloadData()
                    self.dataCache = [:]
                    
                    self.collectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                    
                    
                    
                    
                }
                
            })
        } else if(self.id == 10){
            ref.child("Lessons").child(lessonKey!).child("Words").observe(.value, with: {(snapshot) in
                //self.stopLoadingDialog()
                self.dataWord.removeAll()
                if(snapshot.hasChildren()){
                    
                    for lesson in snapshot.children {
                        let lessonDataSnapshot = lesson as! DataSnapshot
                        
                        //let value = lessonDataSnapshot.childSnapshot(forPath: "Info").childSnapshot(forPath: "nameEng").value as! String
                        
                        let value = WordInfo.init(slot: (lessonDataSnapshot.value as! [String: AnyObject]))
                        
                        if !value.delete {
                            self.dataWord.append(value)
                        }
                        
                        
                    }
                    
                    self.dataWord.sorted(by: { $0.number < $1.number })
                    
                    
                    self.collectionView.reloadData()
                    self.dataCache = [:]
                    
                    self.collectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                    
                    
                    
                }
                
            })
        } else if(self.id == 11){
            ref.child("Lessons").child(lessonKey!).child("Tests").observe(.value, with: {(snapshot) in
                //self.stopLoadingDialog()
                
                self.dataTest.removeAll()
                
                if(snapshot.hasChildren()){
                    
                    for test in snapshot.children {
                        let lessonDataSnapshot = test as! DataSnapshot
                        
                        //let value = lessonDataSnapshot.childSnapshot(forPath: "Info").childSnapshot(forPath: "nameEng").value as! String
                        
                        let value = TestInfo.init(slot: (lessonDataSnapshot.value as! [String: AnyObject]))
                        
                        if !value.delete {
                            self.dataTest.append(value)
                        }
                        
                        
                    }
                    
                    self.dataTest.sorted(by: { $0.number < $1.number })
                    
                    let uid = "FyDDLisKFcgAifEAXbuILau40cC2"
                    //let uid = Auth.auth().currentUser!.uid
                    
                    ref.child("Peoples").child(uid).child("History").child(self.lessonKey!).observeSingleEvent(of: .value, with: {(snapshots) in
                        
                        self.dataCheck.removeAll()
                        
                        
                        
                        if(snapshots.hasChildren()){
                            
                            for testC in snapshots.children {
                                let dss = testC as! DataSnapshot
                                
                                //let value = lessonDataSnapshot.childSnapshot(forPath: "Info").childSnapshot(forPath: "nameEng").value as! String
                                
                                let values = TestCheck.init(slot: (dss.value as! [String: AnyObject]))
                                
                                self.dataCheck.updateValue(values, forKey: values.key)
                                
                                
                                
                            }
                            
                        }
                        self.collectionView.reloadData()
                        self.dataCache = [:]
                        
                        self.collectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                        
                    })
                    
                    
                    
                    
                    
                    
                }
                
            })
        }
    }
    
    func setUpCollectionView() {
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.showsHorizontalScrollIndicator = false
        collectionView!.showsVerticalScrollIndicator = false
        
        
        if self.id == 11 {
            collectionView!.register(UINib.init(nibName: "TestCVCell", bundle: nil), forCellWithReuseIdentifier: "GameCVC")
        }else {
            collectionView!.register(UINib.init(nibName: "GameCVCell", bundle: nil), forCellWithReuseIdentifier: "GameCVC")
            
        }
        collectionView.isHidden = true
        
        
        
        
        //configCollectionView()
        
        //collectionView!.collectionViewLayout = layout
        //collectionView!.reloadData()
        
    }
    
    func configCollectionView() {
        collectionView.isHidden = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        
        if self.id == 11 {
            print(UIDevice.modelName)
            if(UIDevice.isFourInch){
                if UIDevice().isLandscape() {
                    layout.sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
                    layout.itemSize = CGSize(width: 150, height: collectionView!.bounds.height - 50)
                    
                    layout.scrollDirection = .horizontal
                    layout.minimumInteritemSpacing = 0
                    layout.minimumLineSpacing = 20
                }else {
                    layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 40, right: 0)
                    layout.itemSize = CGSize(width: collectionView!.bounds.width - 40, height: collectionView!.bounds.height * 0.6)
                    //layout.itemSize = CGSize(width: collectionView!.bounds.width - 20, height: 500)
                    //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
                    layout.scrollDirection = .vertical
                    layout.minimumInteritemSpacing = 50
                    layout.minimumLineSpacing = 20
                }
            } else if(!UIDevice().isIpad() && UIDevice().isLandscape()){
                
                if(UIDevice.isNotch){
                    layout.sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 30, right: 30)
                    layout.itemSize = CGSize(width: 110, height: (collectionView!.bounds.height / 2) - 40)
                    
                }else {
                    layout.sectionInset = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
                    layout.itemSize = CGSize(width: 110, height: (collectionView!.bounds.height / 2) - 30)
                }
                
                layout.scrollDirection = .horizontal
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 20
                
            }else if(UIDevice().isIpad()) {
                
                var width = collectionView!.bounds.width / 2.5
                
                if(UIDevice().isLandscape()){
                    layout.sectionInset = UIEdgeInsets(top: 70, left: 50, bottom: 70, right: 50)
                }else {
                    layout.sectionInset = UIEdgeInsets(top: 70, left: 50, bottom: 70, right: 50)
                }
                
                
                //print(width)
                
                if(width > 200){
                    width = 200
                }
                
                layout.itemSize = CGSize(width: width , height: 300)
                
                layout.scrollDirection = .vertical
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 30
            }else {
                
                layout.sectionInset = UIEdgeInsets(top: 50, left: 25, bottom: 40, right: 25)
                layout.itemSize = CGSize(width: collectionView!.bounds.width / 2.56, height: 250)
                //layout.itemSize = CGSize(width: collectionView!.bounds.width - 20, height: 500)
                //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
                layout.scrollDirection = .vertical
                layout.minimumInteritemSpacing = 20
                layout.minimumLineSpacing = 20
                
            }
            
            layout.invalidateLayout()
            
            
            collectionView!.collectionViewLayout = layout
            
        }else {
            if(!UIDevice().isIpad() && UIDevice().isLandscape()){
                
                if(UIDevice.isNotch){
                    layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 20, right: 30)
                    layout.itemSize = CGSize(width: 220, height: collectionView!.bounds.height - 25 - 30)
                    
                }else {
                    layout.sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
                    layout.itemSize = CGSize(width: 220, height: collectionView!.bounds.height - 50)
                }
                
                layout.scrollDirection = .horizontal
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 20
                
            }else if(UIDevice().isIpad()) {
                
                var width = collectionView!.bounds.width / 2.5
                
                if(UIDevice().isLandscape()){
                    layout.sectionInset = UIEdgeInsets(top: 70, left: 50, bottom: 70, right: 50)
                }else {
                    layout.sectionInset = UIEdgeInsets(top: 70, left: 50, bottom: 70, right: 50)
                }
                
                
                //print(width)
                
                if(width > 200){
                    width = 200
                }
                
                layout.itemSize = CGSize(width: width , height: 300)
                
                layout.scrollDirection = .vertical
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 30
            }else {
                layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 40, right: 0)
                layout.itemSize = CGSize(width: collectionView!.bounds.width - 40, height: collectionView!.bounds.height * 0.6)
                //layout.itemSize = CGSize(width: collectionView!.bounds.width - 20, height: 500)
                //layout.itemSize = CGSize(width: 250, height: menuCollectionView.bounds.height - 10)
                layout.scrollDirection = .vertical
                layout.minimumInteritemSpacing = 50
                layout.minimumLineSpacing = 20
                
            }
            
            layout.invalidateLayout()
            
            
            collectionView!.collectionViewLayout = layout
        }
        //collectionView!.reloadData()
        
        collectionView.isHidden = false
        
        self.collectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        initBackBtn()
        
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        //print("Life Cycle : didRotate")
        configCollectionView()
        
        if UIDevice().isIpad() || UIDevice().isLandscape(){
            if score == nil {
                loadScore()
            }
            self.scoreView.isHidden = false
            self.backBtn.isHidden = false
            
        }else {
            if(self.id! >= 10){
                self.scoreView.isHidden = true
            }else {
                self.scoreView.isHidden = false
            }
            self.backBtn.isHidden = true
            
        }
        
        self.collectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.contentView.hero.modifiers = [.translate(y: UIScreen.main.bounds.height), .useGlobalCoordinateSpace]
        //initBackBtn()
        configCollectionView()
        
        
        
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

extension GameViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.isInitCollectionView){
            self.indicator.isHidden = true
        }
        
        if self.id == 10 {
            return dataWord.count
        }else if self.id == 11{
            return dataTest.count
        }else {
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "MenuCVC", for: indexPath) as! MenuCollectionViewCell
        
        if self.id == 11 {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCVC", for: indexPath) as! TestCVCell
            
            let slot = dataTest[indexPath.row]
            
            cell = cellAction(cell: cell, action: .Close)
            
            let a = dataCheck[slot.key]
            let bool :Bool = dataCheck[slot.key] == nil ? false : true
            
            
            if indexPath.row == 0 {
                if a != nil {
                    if a!.passed {
                        cell = cellAction(cell: cell, action: .Passed)
                        
                    }else if a!.opened {
                        cell = cellAction(cell: cell, action: .Open)
                        
                    }else {
                        if a!.failed {
                            cell = cellAction(cell: cell, action: .Open)
                            
                        } else {
                            cell = cellAction(cell: cell, action: .Close)
                            
                        }
                    }
                }else {
                    cell = cellAction(cell: cell, action: .Open)
                }
            } else {
                
                var co = indexPath.row - 1
                var lock = false
                
                while co >= 0 {
                    let coKey :TestInfo? = dataTest[co]
                    if coKey != nil {
                        let coBool :Bool = dataCheck[coKey!.key] == nil ? false : true
                        if !coBool {
                            lock = true
                        }
                        
                        if co == 0 {
                            if lock {
                                cell = cellAction(cell: cell, action: .Close)
                            } else {
                                let lastPositionKey :TestInfo? = dataTest[indexPath.row - 1]
                                if lastPositionKey != nil {
                                    
                                    let lastBool :Bool = dataCheck[lastPositionKey!.key] == nil ? false : true
                                    
                                    if bool {
                                        let it = dataCheck[slot.key]
                                        if it!.passed {
                                            cell = cellAction(cell: cell, action: .Passed)
                                        }else if it!.opened {
                                            cell = cellAction(cell: cell, action: .Open)
                                        }else {
                                            if it!.failed {
                                                cell = cellAction(cell: cell, action: .Open)
                                            }else {
                                                cell = cellAction(cell: cell, action: .Close)

                                            }
                                        }
                                    }else if lastBool {
                                        let it = dataCheck[lastPositionKey!.key]
                                        if !it!.passed {
                                            cell = cellAction(cell: cell, action: .Close)

                                        }else {
                                            cell = cellAction(cell: cell, action: .Open)

                                        }
                                    } else {
                                        cell = cellAction(cell: cell, action: .Close)

                                    }

                                    
                                }
                                
                                
                            }
                        }
                    }
                    co -= 1
                }
                
                
            }
            
            /*
             if a != nil {
             
             if a!.passed && a!.opened {
             cell = cellAction(cell: cell, action: .Passed)
             }else if a!.opened {
             cell = cellAction(cell: cell, action: .Open)
             }else if indexPath.row == 0{
             cell = cellAction(cell: cell, action: .Open)
             
             }
             }
             */
            //print(a?.key)
            
            
            //cell.viewBg.backgroundColor = bgColorDark
            //cell.titleLabel.textColor = UIColor.white.withAlphaComponent(1)
            
            cell.titleLabel.text = "\(indexPath.row + 1)"
            
            if(UIDevice.init().isIpad()){
                
                if(UIDevice.init().isPortrait()){
                    cell.titleLabel.fontSize(size: Int((collectionView.bounds.height / 8 )/1))
                }else {
                    cell.titleLabel.fontSize(size: Int((collectionView.bounds.width / 9 )/1))
                }
            }else {
                if(UIDevice.init().isPortrait()){
                    cell.titleLabel.fontSize(size: Int((collectionView.bounds.height / 8 )/1))
                }else {
                    cell.titleLabel.fontSize(size: Int((collectionView.bounds.width / 10 )/1))
                }
            }
            
            
            
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCVC", for: indexPath) as! GameCVCell
            
            cell.imageView.image = nil
            cell.viewBG.backgroundColor = bgColorDark
            
            
            
            
            cell.titleViewBg.backgroundColor = bgColorDark?.withAlphaComponent(0.5)
            
            //cell.titleViewBg.layerGradient(color: [PrimaryColor().color_game_blue,PrimaryColor().color_game_blue_dark])
            
            //cell.titleLabel.textColor = UIColor.white.withAlphaComponent(0.9)
            cell.titleLabel.textColor = UIColor.white.withAlphaComponent(1)
            
            if(UIDevice.init().isIpad()){
                if(UIDevice.init().isPortrait()){
                    cell.titleLabel.fontSize(size: Int((collectionView.bounds.height / 10 )/2.8))
                }else {
                    cell.titleLabel.fontSize(size: Int((collectionView.bounds.width / 10 )/2.9))
                }
            }else {
                if(UIDevice.init().isPortrait()){
                    cell.titleLabel.fontSize(size: Int((collectionView.bounds.height / 10 )/1.7))
                }else {
                    cell.titleLabel.fontSize(size: Int((collectionView.bounds.width / 10 )/2))
                }
            }
            
            if self.id == 10 {
                
                let slot = dataWord[indexPath.row]
                
                if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                    cell.titleLabel.text = slot.nameThai
                    cell.unknownLabel.text = "ไม่พบรูป"
                    
                }else {
                    cell.unknownLabel.text = "Unknown Image"
                    cell.titleLabel.text = slot.nameEng
                    
                }
                
                let imageSource :Image? = dataCache[indexPath.row] != nil ? dataCache[indexPath.row] : nil
                
                if slot.cover.count == 0 {
                    cell.unknownLabel.isHidden = false
                }else {
                    cell.unknownLabel.isHidden = true
                }
                
                if imageSource != nil {
                    cell.imageView.image = imageSource
                }else {
                    
                    Alamofire.request(slot.cover).responseImage { response in
                        if let image = response.result.value {
                            
                            self.dataCache.updateValue(image, forKey: indexPath.row)
                            //self.dataCache[indexPath.row] = image
                            
                            //self.updateCache(position: indexPath.row, value: image)
                            
                            
                            cell.imageView.image = image
                            
                            
                        }
                    }
                }
                
            }else {
                
                let slot = data[indexPath.row]
                
                if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                    cell.titleLabel.text = slot.nameThai
                    
                }else {
                    cell.titleLabel.text = slot.nameEng
                    
                }
                
                let imageSource :Image? = dataCache[indexPath.row] != nil ? dataCache[indexPath.row] : nil
                
                if imageSource != nil {
                    cell.imageView.image = imageSource
                }else {
                    
                    Alamofire.request(slot.cover).responseImage { response in
                        if let image = response.result.value {
                            
                            self.dataCache.updateValue(image, forKey: indexPath.row)
                            //self.dataCache[indexPath.row] = image
                            
                            //self.updateCache(position: indexPath.row, value: image)
                            
                            cell.imageView.image = image
                            
                            
                        }
                        
                    }
                }
            }
            
            return cell
            
        }
        
        
    }
    
    enum Action {
        case Close
        case Open
        case Passed
    }
    
    func cellAction(cell :TestCVCell,action :Action) -> TestCVCell{
        //0 = Close
        //1 = Open
        //2 = Passed
        if action == .Passed {
            cell.viewBg.backgroundColor = UIColor.yellow
            cell.titleLabel.textColor = UIColor.black
            return cell
        }else if action == .Open {
            cell.viewBg.backgroundColor = UIColor.white
            cell.titleLabel.textColor = bgColorDark
            return cell
            
        }else {
            cell.viewBg.backgroundColor = bgColorDark
            cell.titleLabel.textColor = UIColor.white
            return cell
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.id! == 0 || self.id! == 1 {
            let vc = AppConfig.init().requireViewController(storyboard: CallCenter.init().MainStoryboard, viewController: CallCenter.init().GameViewController) as! GameViewController
            
            vc.bgColor = bgColor
            vc.bgColorDark = bgColorDark
            vc.toID = toID
            vc.id = self.id! + 10
            vc.lessonKey = data[indexPath.row].key
            vc.hideScore = true
            if(langCoreData?.now() == LangCoreData.Language.Thai){
                vc.titleText = data[indexPath.row].nameThai
                
            }else {
                vc.titleText = data[indexPath.row].nameEng
            }
            
            
            self.actionVC(this: self, viewController: vc)
            
        }
        
    }
    
}
