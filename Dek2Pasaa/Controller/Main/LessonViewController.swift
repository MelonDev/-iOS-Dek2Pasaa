//
//  LessonViewController.swift
//  Dek2Pasaa
//
//  Created by Android on 12/4/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import AlamofireImage

class LessonViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! LessonTableViewCell
        
        let slot = dataTable[indexPath.row]
        
        cell.title.text = "\(slot.title!):"
        cell.message.text = "\(slot.message!)"
        
        if slot.id != 0 {
            
            
            if slot.audioURL != nil {
                cell.circleA.isHidden = false
            } else {
                cell.circleA.isHidden = true
                
            }
        }else {
            cell.circleA.isHidden = true
            cell.circleB.isHidden = true
            
        }
        
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismissAction()
    }
    
    @IBOutlet weak var contentViewSafe: UIView!
    @IBOutlet weak var choiceView: UIView!
    @IBOutlet weak var choiceA: UIView!
    @IBOutlet weak var choiceB: UIView!
    @IBOutlet weak var choiceALabel: UILabel!
    @IBOutlet weak var choiceBLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var navigatorPageView: UIView!
    @IBOutlet weak var navigationLeftView: UIView!
    @IBOutlet weak var navLeftLabel: UILabel!
    @IBOutlet weak var navigationRightView: UIView!
    @IBOutlet weak var navRightLabel: UILabel!
    @IBOutlet weak var contentImageView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var masterKey :String? = nil
    var key :String? = nil
    var position :Int? = nil
    
    var id :Int? = nil
    
    var dataWord :[WordInfo] = []
    var dataTest :[TestInfo] = []
    
    var dataTable :[tableData] = []
    
    struct tableData {
        var title :String?
        var message :String?
        var audioURL :String?
        var id :Int
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backView.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(backActions(_:))))
        self.initVC()
        
        self.backBtn.hero.id = "BACK_\(CallCenter.init().LessonViewController)"
        self.contentView.hero.id = "CONTENT_VIEW"
        
        contentImageView.layer.cornerRadius = 10
        contentImageView.backgroundColor = UIColor.clear
        imageView.layer.cornerRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let windowHeight : CGFloat = 30
        let windowWidth  : CGFloat = 30
        
        let header = UIView()
        header.backgroundColor = UIColor.clear
        header.frame = CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight)
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = UIView()
        
        
        configContentView()
        
        choiceA.backgroundColor = UIColor.white
        choiceB.backgroundColor = UIColor.white
        
        choiceView.backgroundColor = UIColor.clear
        contentViewSafe.backgroundColor = UIColor.clear
        navigatorPageView.backgroundColor = UIColor.clear
        
        navigationLeftView.layer.cornerRadius = 30
        navigationRightView.layer.cornerRadius = 30
        
        if(LangCoreData.init().now() == LangCoreData.Language.Thai){
            navLeftLabel.text = "ก่อนหน้า"
            navRightLabel.text = "ถัดไป"
        }else {
            navLeftLabel.text = "Previous"
            navRightLabel.text = "Next"
        }
        
        
        
        
        configView()
        
        // let device = UIDevice.init()
        
        
        
        
        
    }
    
    func loadLessonFirebase(){
        let ref = Database.database().reference()
        ref.child("Lessons").child(masterKey!).child("Words").observe(.value, with: {(snapshot) in
            //self.stopLoadingDialog()
            self.dataWord.removeAll()
            self.dataTable.removeAll()
            
            if(snapshot.hasChildren()){
                
                for lesson in snapshot.children {
                    let lessonDataSnapshot = lesson as! DataSnapshot
                    
                    //let value = lessonDataSnapshot.childSnapshot(forPath: "Info").childSnapshot(forPath: "nameEng").value as! String
                    
                    let value = WordInfo.init(slot: (lessonDataSnapshot.value as! [String: AnyObject]))
                    
                    if !value.delete {
                        self.dataWord.append(value)
                    }
                    
                    
                }
                
                self.dataWord = self.dataWord.sorted(by: { $0.number < $1.number })
                self.loadLesson()
            }
            self.tableView.reloadData()
            
        })
    }
    
    func loadLesson(){
        for i in dataWord {
            if i.key.contains(self.key!){
                if i.read.count > 0 {
                    dataTable.append(tableData.init(title: "คำอ่าน", message: i.read, audioURL: nil, id: 0))
                }
                if i.nameThai.count > 0 {
                    dataTable.append(tableData.init(title: "ภาษาไทย", message: i.nameThai, audioURL: i.thaiSound, id: 1))
                }
                if i.nameEng.count > 0 {
                    dataTable.append(tableData.init(title: "ภาษาอังกฤษ", message: i.nameEng, audioURL: i.engSound, id: 2))
                }
                
                self.tableView.reloadData()
                
                Alamofire.request(i.cover).responseImage { response in
                    if let image = response.result.value {
                        
                        //self.dataCache.updateValue(image, forKey: indexPath.row)
                       
                        //cell.imageView.image = image
                        
                        self.imageView.image = image
                        
                        
                        
                    }
                }
            }
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
        
        if self.id! == 110 {
            loadLessonFirebase()
        }
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configView()
        
    }
    
    func configView() {
        for constraint in self.contentView.constraints {
            if constraint.identifier == "contentVIewSafeTrailing" {
                if UIDevice().isPortrait(){
                    constraint.constant = 0
                }else {
                    if UIDevice().isLandscapeLeft(){
                        constraint.constant = 0
                    }else {
                        if UIDevice.hasNotch() {
                            constraint.constant = 44
                        }else {
                            constraint.constant = 0
                        }
                    }
                    
                }
            }
            if constraint.identifier == "contentVIewSafeBottom" {
                if UIDevice().isPortrait(){
                    if UIDevice.hasNotch() {
                        constraint.constant = 22
                    }else {
                        constraint.constant = 0
                    }
                }else {
                    if UIDevice.hasNotch() {
                        constraint.constant = 22
                    }else {
                        constraint.constant = 0
                    }
                }
            }
            
            
            
        }
        
        for constraint in self.contentViewSafe.constraints {
            if constraint.identifier == "nav_page_bottom" {
                if UIDevice.hasNotch() {
                    if UIDevice().isLandscape(){
                        constraint.constant = 10
                    }else {
                        constraint.constant = 20
                    }
                }else {
                    constraint.constant = 0
                }
            }
        }
        
        for constraint in self.headerView.constraints {
            if constraint.identifier == "image_content_height" {
                
                if UIDevice().isIpad() {
                    if UIDevice().isLandscape(){
                        //print("1")
                        constraint.constant = 300
                    }else {
                        //print("2")
                        constraint.constant = 400
                    }
                }else {
                    if UIDevice.hasNotch() {
                        //print("3")
                        constraint.constant = 200
                    }else {
                        //print("4")
                        constraint.constant = 150
                    }
                }
            }
        }
        
        for constraint in self.navigatorPageView.constraints {
            if constraint.identifier == "nav_right_land" {
                if UIDevice.hasNotch() {
                    constraint.constant = 0
                }else {
                    constraint.constant = -10

                }
            }
            if constraint.identifier == "nav_left_land" {
                if UIDevice.hasNotch() {
                    constraint.constant = 0
                }else {
                    constraint.constant = -10
                    
                }
            }
            
        }
        
        for constraint in self.choiceView.constraints {
            if constraint.identifier == "choiceViewHeight" {
                if UIDevice().isPortrait(){
                    if UIDevice.hasNotch() {
                        constraint.constant = 180
                        
                    }else {
                        constraint.constant = 150
                    }
                    
                }else {
                    constraint.constant = 80
                }
                
            }
            if constraint.identifier == "choiceA_center_port" {
                if UIDevice().isLandscape() {
                    
                    if UIDevice.hasNotch() {
                        constraint.constant = -122
                        
                    }else {
                        constraint.constant = -105
                    }
                }else {
                    constraint.constant = 0
                }
                
            }
            
            if constraint.identifier == "choiceB_center_port" {
                if UIDevice().isLandscape() {
                    if UIDevice.hasNotch() {
                        constraint.constant = 122
                        
                    }else {
                        constraint.constant = 105
                    }
                }else {
                    constraint.constant = 0
                }
                
                
            }
            
            
        }
        
        for constraint in self.choiceA.constraints {
            if constraint.identifier == "choiceHeight" {
                if UIDevice().isPortrait(){
                    if UIDevice.hasNotch() {
                        constraint.constant = 60
                        choiceA.layer.cornerRadius = constraint.constant / 2
                        choiceB.layer.cornerRadius = constraint.constant / 2
                    }else {
                        constraint.constant = 50
                        choiceA.layer.cornerRadius = constraint.constant / 2
                        choiceB.layer.cornerRadius = constraint.constant / 2
                    }
                }else {
                    if UIDevice.hasNotch() {
                        constraint.constant = 60
                        choiceA.layer.cornerRadius = constraint.constant / 2
                        choiceB.layer.cornerRadius = constraint.constant / 2
                    }else {
                        constraint.constant = 50
                        choiceA.layer.cornerRadius = constraint.constant / 2
                        choiceB.layer.cornerRadius = constraint.constant / 2
                    }
                    
                }
                
            }
            if constraint.identifier == "choiceWidth" {
                //print(contentViewSafe.bounds.width)
                if UIDevice().isPortrait(){
                    constraint.constant =  300
                }else {
                    if UIDevice.hasNotch() {
                        constraint.constant =  230
                    }else {
                        constraint.constant =  200
                    }
                }
                
            }
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        configContentView()
        configView()
    }
    
    
    func configContentView() {
        
        if UIDevice.init().isIpad() || UIDevice.init().isPortrait() {
            self.contentView.layer.cornerRadius = 20
            self.contentViewSafe.layer.cornerRadius = 20
            
            if #available(iOS 11.0, *) {
                self.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                self.contentViewSafe.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            }
        }else {
            self.contentView.layer.cornerRadius = 0
            self.contentViewSafe.layer.cornerRadius = 0
            
            if #available(iOS 11.0, *) {
                self.contentView.layer.maskedCorners = [ .layerMinXMinYCorner,.layerMinXMaxYCorner]
                self.contentViewSafe.layer.maskedCorners = [ .layerMinXMinYCorner,.layerMinXMaxYCorner]
            }
        }
    }
    
    @objc func backActions(_ sender:UITapGestureRecognizer?){
        //print("TAPPED")
        self.dismissAction()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
}
