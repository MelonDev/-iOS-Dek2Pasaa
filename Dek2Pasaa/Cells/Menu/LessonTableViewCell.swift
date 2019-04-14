//
//  LessonTableViewCell.swift
//  Dek2Pasaa
//
//  Created by Android on 13/4/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import UIKit
import AVFoundation

class LessonTableViewCell: UITableViewCell {

    @IBOutlet weak var circleA: UIView!
    @IBOutlet weak var circleB: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    
    //var player: AVPlayer? = nil
    
    var actionBlockAudio: (() -> Void)? = nil
    var actionBlockRecord: (() -> Void)? = nil


    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        circleA.layer.cornerRadius = 20
        circleB.layer.cornerRadius = 20

        circleA.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(audioTapped(_:))))
        circleB.onClick(tap: UITapGestureRecognizer(target: self, action: #selector(recordTapped(_:))))


        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func audioTapped(_ sender:UITapGestureRecognizer?){
        
        if self.actionBlockAudio != nil {
            actionBlockAudio!()
            //print("PLAY_")

        }else {
            //print("STOP")

        }
        //print("PLAY")
        //player.play()
    }
    
    @objc func recordTapped(_ sender:UITapGestureRecognizer?){
        
        if self.actionBlockRecord != nil {
            actionBlockRecord!()
            //print("PLAY_")
            
        }else {
            //print("STOP")
            
        }
        //print("PLAY")
        //player.play()
    }
    
    
}
