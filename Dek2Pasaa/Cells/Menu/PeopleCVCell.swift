//
//  PeopleCVCell.swift
//  Dek2Pasaa
//
//  Created by Android on 15/4/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import UIKit

class PeopleCVCell: UICollectionViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var circleImageBg: UIView!
    
    @IBOutlet weak var circleImageProfile: UIImageView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreTitle: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBg.layer.cornerRadius = 16
        circleImageBg.layer.cornerRadius = 40
        
        circleImageProfile.layer.backgroundColor = UIColor.clear.cgColor
        
        content.layer.cornerRadius = 16
        if #available(iOS 11.0, *) {
            content.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        highScore.isHidden = true
        
        nameLabel.isHidden = true
        scoreLabel.isHidden = true
        nameTitle.isHidden = true
        scoreTitle.isHidden = true
    }
    
    func setHighScore(){
        
        
        if(LangCoreData.init().now() == LangCoreData.Language.Thai){
            highScore.text = "คะแนนสูงสุด"
        }else {
            highScore.text = "High Score"
        }
       
    }

}
