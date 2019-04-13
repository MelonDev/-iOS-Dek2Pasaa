//
//  LessonViewController.swift
//  Dek2Pasaa
//
//  Created by Android on 12/4/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! LessonTableViewCell
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
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
                        print("1")
                        constraint.constant = 300
                    }else {
                        print("2")
                        constraint.constant = 400
                    }
                }else {
                    if UIDevice.hasNotch() {
                        print("3")
                        constraint.constant = 200
                    }else {
                        print("4")
                        constraint.constant = 120
                    }
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
