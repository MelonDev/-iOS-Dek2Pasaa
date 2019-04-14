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
import AVFoundation
//import AudioPlayer
import Speech



class LessonViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,SFSpeechRecognizerDelegate {
    
    //var p: AVAudioPlayer?
    
    
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
    @IBOutlet weak var unknownImageLabel: UILabel!
    @IBOutlet weak var navigationLeftView: UIView!
    @IBOutlet weak var navLeftLabel: UILabel!
    @IBOutlet weak var navigationRightView: UIView!
    @IBOutlet weak var navRightLabel: UILabel!
    @IBOutlet weak var contentImageView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    
    
    var masterKey :String? = nil
    var key :String? = nil
    var position :Int? = nil
    
    var id :Int? = nil
    
    
    var loadingAlert :UIAlertController? = nil
    var processing = false
    
    var audioLayer :AVPlayerLayer? = nil
    
    var speechDialog :UIAlertController? = nil
    
    var audioSession :AVAudioSession? = nil
    
    var word :String? = nil
    
    
    var dataWord :[WordInfo] = []
    var dataTest :[TestInfo] = []
    
    var dataTable :[tableData] = []
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioEngine :AVAudioEngine? = AVAudioEngine()
    
    //var player: AVPlayer!
    
    struct tableData {
        var title :String?
        var message :String?
        var audioURL :String?
        var id :Int
        var languege :Languege
    }
    
    //private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    private var speechRecognizer :SFSpeechRecognizer? = nil
    
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
        
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        footer.frame = CGRect(x: 0, y: 0, width: windowWidth, height: 90)
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
        
        unknownImageLabel.isHidden = true
        navigationLeftView.isHidden = true
        navigationRightView.isHidden = true
        imageIndicator.isHidden = true
        
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
            unknownImageLabel.text = "ไม่พบรูปภาพ"
        }else {
            navLeftLabel.text = "Previous"
            navRightLabel.text = "Next"
            unknownImageLabel.text = "Image not found"
            
        }
        
        
        
        
        configView()
        
        navigationLeftView.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(preLesson(_:))))
        navigationRightView.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(nextLesson(_:))))
        
        
        // let device = UIDevice.init()
        
        
        
        
        
        
    }
    
    func showRecordDialog(title :String,message :String,positive :String,negative :String, word :String){
        
        speechDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: positive, style: .default, handler: { (action) -> Void in
            self.speechDialog!.dismissAction()
            self.checkWord(word: word)
        })
        let cancel = UIAlertAction(title: negative, style: .default, handler: { (action) -> Void in
            self.speechDialog!.dismissAction()
            self.stopRecording()
        })
        //let actionNegative = UIAlertAction(title: "English", style: .default, handler: { (action) -> Void in
        //})
        
        speechDialog!.addAction(cancel)
        speechDialog!.addAction(confirm)
        
        self.present(speechDialog!, animated: true, completion: nil)
        //startRecording()
        
    }
    
    func stopRecording() {
        
        if audioEngine != nil {
            audioEngine!.stop()
        }
        if recognitionRequest != nil {
            recognitionRequest!.endAudio()
        }
        
        self.audioEngine!.inputNode.reset()
        self.audioEngine!.inputNode.removeTap(onBus: 0)
        recognitionTask!.cancel()
        
        
        do {
            try audioSession!.setCategory(AVAudioSession.Category.playback)
            try audioSession!.setMode(AVAudioSession.Mode.moviePlayback)
            try audioSession!.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
 

        
        //recognitionTask = nil
        //recognitionRequest = nil
        
        speechRecognizer = nil
        //audioEngine = nil
        
        //audioSession = nil
        audioEngine = nil
        recognitionRequest = nil
        recognitionTask = nil
        
        
    }
    
    func checkWord(word :String){
        if word.contains(self.word != nil ? self.word! : ""){
            if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                self.showDialog(title: "ถูกต้อง", message: "เยี่ยมมาก! พยายามต่อไปนะ", positiveString: "ปิด", completion: {
                    self.stopRecording()

                })
            }else {
                self.showDialog(title: "Correct", message: "Great! Keep trying", positiveString: "Close", completion: {
                    self.stopRecording()

                })
            }
        }else {
            if self.word != nil {
                if self.word!.count > 0 {
                    if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                        
                        self.showDialog(title: "ยังไม่ถูกนะ", message: "เมื่อกี้คุณพูดว่า \(self.word!)", positiveString: "ปิด", completion: {
                            self.stopRecording()
                        })
                    }else {
                        self.showDialog(title: "Not correct", message: "You said \(self.word!)", positiveString: "Close", completion: {
                            self.stopRecording()

                        })
                    }
                
                }else {
                    if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                        
                        self.showDialog(title: "ไม่พบการพูด", message: "ขออภัยด้วย เราไม่สามารถตรวจสอบให้ได้", positiveString: "ปิด", completion: {
                            self.stopRecording()

                        })
                    }else {
                        self.showDialog(title: "Not found speaking", message: "Sorry, we can't check it", positiveString: "Close", completion: {
                            self.stopRecording()

                        })
                    }
                }
            } else {
                if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                    
                    self.showDialog(title: "ไม่พบการพูด", message: "ขออภัยด้วย เราไม่สามารถตรวจสอบให้ได้", positiveString: "ปิด", completion: {
                        self.stopRecording()

                    })
                }else {
                    self.showDialog(title: "Not found speaking", message: "Sorry, we can't check it", positiveString: "Close", completion: {
                        self.stopRecording()

                    })
                }
            }
        }
    }
    
    func checkRecordPermission(word :String,languege :Languege){
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            DispatchQueue.main.async {
                
                switch authStatus {
                case .authorized:
                    if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                        self.showRecordDialog(title: "อ่านออกเสียง", message: "กรุณาพูดว่า '\(word)'", positive: "ตรวจสอบ", negative: "ยกเลิก", word: word)
                    }else {
                        self.showRecordDialog(title: "Read aloud", message: "Please say '\(word)'", positive: "Check", negative: "Cancel", word: word)
                    }
                    self.word = nil
                    self.startRecording(languege: languege)
                    
                case .denied:
                    //print("User denied access to speech recognition")
                    if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                        self.showDialog(title: "คุณปฏิเสธการเข้าถึงระบบวิเคราะห์เสียง", message: nil, positiveString: "ปิด", completion: {})
                    }else {
                        self.showDialog(title: "User denied access to speech recognition", message: nil, positiveString: "Close", completion: {})
                    }
                    
                case .restricted:
                    //isButtonEnabled = false
                    //print("Speech recognition restricted on this device")
                    if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                        self.showDialog(title: "ระบบวิเคราะห์เสียงถูกจำกัดบนอุปกรณ์นี้", message: nil, positiveString: "ปิด", completion: {})
                    }else {
                        self.showDialog(title: "Speech recognition restricted on this device", message: nil, positiveString: "Close", completion: {})
                    }
                    
                    
                case .notDetermined:
                    //isButtonEnabled = false
                    //print("Speech recognition not yet authorized")
                    if(LangCoreData.init().now() == LangCoreData.Language.Thai){
                        self.showDialog(title: "ระบบวิเคราะห์เสียงยังไม่ได้รับอนุญาต", message: nil, positiveString: "ปิด", completion: {})
                    }else {
                        self.showDialog(title: "Speech recognition not yet authorized", message: nil, positiveString: "Close", completion: {})
                    }
                    
                }
                
            }
            
        }
    }
    
    func startRecording(languege :Languege) {
        
        if languege == .thai {
            speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "th_TH"))
        }else if languege == .english {

            speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
        }
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        
        audioSession = AVAudioSession.sharedInstance()
        do {
            //try audioSession!.setCategory(AVAudioSession.Category.playAndRecord)
            try audioSession!.setCategory(AVAudioSession.Category.record)
            try audioSession!.setMode(AVAudioSession.Mode.measurement)
            try audioSession!.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        //self.audioEngine = nil
        self.audioEngine = AVAudioEngine()
        
        let inputNode = audioEngine!.inputNode
        
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer!.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                //self.textView.text = result?.bestTranscription.formattedString
                
                print(result!.bestTranscription.formattedString)
                //self.speechDialog?.message = result!.bestTranscription.formattedString
                self.word = result!.bestTranscription.formattedString
                
                isFinal = (result?.isFinal)!
                
            }
            
            if error != nil || isFinal {
                print("DEBUG: \(error.debugDescription) LOCAL: \(error!.localizedDescription)")
                if self.audioEngine != nil {
                    self.audioEngine!.stop()
                    inputNode.removeTap(onBus: 0)
                    
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                }
                
                //self.microphoneButton.isEnabled = true
            }
        })
        
        //inputNode.reset()
        inputNode.removeTap(onBus: 0)
        
            let recordingFormat = inputNode.outputFormat(forBus: 0)
        
       inputNode.installTap(onBus: 0, bufferSize: 4096, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        
        
        
        audioEngine!.prepare()
        
        do {
            try audioEngine!.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        
        //textView.text = "Say something, I'm listening!"
        
    }
    
    
    
    @objc func nextLesson(_ sender:UITapGestureRecognizer?){
        loadLessonFirebase(actionId: 2)
    }
    
    @objc func preLesson(_ sender:UITapGestureRecognizer?){
        loadLessonFirebase(actionId: 1)
        
    }
    
    /* @objc func audioTapped(_ sender:UITapGestureRecognizer?){
     
     print("PLAY")
     player.play()
     }
     */
    
    func loadLessonFirebase(actionId :Int){
        let ref = Database.database().reference()
        ref.child("Lessons").child(masterKey!).child("Words").observe(.value, with: {(snapshot) in
            //self.stopLoadingDialog()
            self.dataWord.removeAll()
            self.dataTable.removeAll()
            
            if(snapshot.hasChildren()){
                
                //print(self.position)
                
                for lesson in snapshot.children {
                    let lessonDataSnapshot = lesson as! DataSnapshot
                    
                    //let value = lessonDataSnapshot.childSnapshot(forPath: "Info").childSnapshot(forPath: "nameEng").value as! String
                    
                    let value = WordInfo.init(slot: (lessonDataSnapshot.value as! [String: AnyObject]))
                    
                    if !value.delete {
                        self.dataWord.append(value)
                    }
                    
                    
                }
                
                
                
                self.dataWord = self.dataWord.sorted(by: { $0.number < $1.number })
                if actionId == 0 {
                    self.loadLesson(keys: self.key!)
                }else if actionId == 1 {
                    //PRE LESSON
                    if self.position! > 1 {
                        self.position = self.position! - 1
                        
                        for i in self.dataWord {
                            if i.number == self.position {
                                self.loadLesson(keys: self.dataWord[self.position! - 1].key)
                            }
                        }
                    }
                }else if actionId == 2 {
                    //NEXT LESSON
                    
                    if self.position! < self.dataWord.count {
                        self.position = self.position! + 1
                        
                        for i in self.dataWord {
                            if i.number == self.position {
                                self.loadLesson(keys: self.dataWord[self.position! - 1].key)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
            
        })
    }
    
    func loadLesson(keys :String){
        for i in dataWord {
            if i.key.contains(keys){
                if i.read.count > 0 {
                    dataTable.append(tableData.init(title: "คำอ่าน", message: i.read, audioURL: nil, id: 0, languege: .none))
                }
                if i.nameThai.count > 0 {
                    dataTable.append(tableData.init(title: "ภาษาไทย", message: i.nameThai, audioURL: i.thaiSound, id: 1, languege: .thai))
                }
                if i.nameEng.count > 0 {
                    dataTable.append(tableData.init(title: "ภาษาอังกฤษ", message: i.nameEng, audioURL: i.engSound, id: 2, languege: .english))
                }
                
                self.tableView.reloadData()
                
                if i.number == 1 {
                    navigationLeftView.isHidden = true
                    navigationRightView.isHidden = false
                }else if i.number == self.dataWord.count {
                    navigationLeftView.isHidden = false
                    navigationRightView.isHidden = true
                }else {
                    navigationLeftView.isHidden = false
                    navigationRightView.isHidden = false
                }
                
                //self.position = i.number
                //self.masterKey = i.masterKey
                //self.key = i.key
                
                self.imageView.image = nil
                
                if i.cover.count > 0 {
                    unknownImageLabel.isHidden = true
                    
                    DispatchQueue.main.async {
                        self.imageIndicator.isHidden = false
                    }
                    
                    Alamofire.request(i.cover).responseImage { response in
                        if let image = response.result.value {
                            
                            //self.dataCache.updateValue(image, forKey: indexPath.row)
                            self.imageIndicator.isHidden = true
                            
                            self.imageView.image = image
                            
                            
                            
                        }
                    }
                } else {
                    unknownImageLabel.isHidden = false
                    
                    
                }
            }
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
        
        if self.id! == 110 {
            loadLessonFirebase(actionId: 0)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! LessonTableViewCell
        
        let slot = dataTable[indexPath.row]
        
        cell.title.text = "\(slot.title!):"
        cell.message.text = "\(slot.message!)"
        
        
        if slot.id != 0 {
            
            
            
            if slot.audioURL!.count > 0 {
                cell.circleA.isHidden = false
                
                //print(slot.audioURL!)
                
                
                /* let url = URL.init(string: "\(slot.audioURL!).mp3")!
                 
                 let playerItem = AVPlayerItem.init(url: url)
                 let player = AVPlayer.init(playerItem: playerItem)
                 player.play()
                 */
                
                
                
                /*do {
                 let a = try AudioPlayer.init(contentsOf: url)
                 a.play()
                 }catch {
                 print(error)
                 }*/
                
                //cell.actionBlockRecord = nil
                
                
                cell.actionBlockAudio = {
                    
                    var player: AVPlayer? = nil
                    let url  = URL.init(string:  "\(slot.audioURL!).mp3")
                    
                    
                    let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
                    
                    NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                    
                    
                    player = AVPlayer(playerItem: playerItem)
                    player?.volume = 1.0
                    
                    let playerLayer = AVPlayerLayer(player: player!)
                    
                    //playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
                    self.view.layer.addSublayer(playerLayer)
                    
                    player!.play()
                    
                    self.run(after: 0, completion: {
                        self.showLoadingAudioAlert(playerLayer: playerLayer)
                        self.processing = true
                    })
                    
                    self.run(after: 30, completion: {
                        if self.processing {
                            self.processing = false
                            player!.pause()
                            self.hideLoadingAudioAlert()
                            self.audioLayer?.removeFromSuperlayer()
                            
                            if(LangCoreData().now() == LangCoreData.Language.Thai){
                                self.showDialog(title: "เกิดข้อผิดพลาด", message: "ข้อมูลไฟล์เสียงโหลดนานเกินไป อาจเกิดจากอินเทอร์เน็ตที่ไม่ดีหรือไฟล์ได้รับความเสียหาย กรุณาลองใหม่อีกครั้ง", positiveString: "รับทราบ", completion: {})
                                //loadingAlert = UIAlertController(title: nil , message:"กำลังโหลดข้อมูล", preferredStyle: .alert)
                            }else {
                                self.showDialog(title: "Error", message: "Audio data loaded for too long May be caused by poor internet or file being damaged ,Please try again", positiveString: "Close", completion: {})
                            }
                        }
                        
                        //print("PAUSE")
                    })
                    //print("TEST")
                }
                
            } else {
                cell.circleA.isHidden = true
                cell.actionBlockAudio = nil
                
                
            }
            
            cell.actionBlockRecord = {
                self.checkRecordPermission(word: slot.message!, languege: slot.languege)
            }
            
        }else {
            cell.circleA.isHidden = true
            cell.circleB.isHidden = true
            
        }
        
        return cell
    }
    
    enum Languege {
        case thai
        case english
        case none
    }
    
    func run(after second:Int,completion :@escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(second)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            completion()
        }
    }
    
    @objc func playerDidFinishPlaying(sender: Notification) {
        hideLoadingAudioAlert()
        audioLayer?.removeFromSuperlayer()
        self.processing = false
    }
    
    
    func showDialog(title :String,message :String?,positiveString :String ,completion :@escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionPositive = UIAlertAction(title: positiveString, style: .cancel, handler: { (action) -> Void in
            alert.dismissAction()
            completion()
        })
        //let actionNegative = UIAlertAction(title: "English", style: .default, handler: { (action) -> Void in
        //})
        
        alert.addAction(actionPositive)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showLoadingAudioAlert(playerLayer :AVPlayerLayer) {
        //print("asfjwaefijdfgsdafgk,")
        
        self.audioLayer = playerLayer
        
        loadingAlert = UIAlertController(title: nil , message:"Loading..", preferredStyle: .alert)
        
        if(LangCoreData().now() == LangCoreData.Language.Thai){
            loadingAlert!.title = "กำลังโหลดไฟล์เสียง.."
            loadingAlert!.message = "ความเร็วในการโหลดข้อมูลขึ้นอยู่อัตราความเร็วอินเทอร์เน็ตของท่าน"
            //loadingAlert = UIAlertController(title: nil , message:"กำลังโหลดข้อมูล", preferredStyle: .alert)
        }else {
            loadingAlert!.title = "Loading audio file.."
            loadingAlert!.message = "Data loading speed depends on your internet speed"
            
            
        }
        
        
        loadingAlert!.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10,y: 5,width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        loadingAlert!.view.addSubview(loadingIndicator)
        self.present(loadingAlert!, animated: true)
        
    }
    
    func hideLoadingAudioAlert() {
        
        loadingAlert?.dismissAction()
        
    }
    
    
    
}


