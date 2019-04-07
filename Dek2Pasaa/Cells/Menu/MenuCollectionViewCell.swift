//
//  MenuCollectionViewCell.swift
//  Dek2Pasaa
//
//  Created by Android on 28/3/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var cellBgInsideView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconViewInside: UIView!
    
    @IBOutlet weak var imageIcon: UIImageView!
    //@IBOutlet weak var titleBgBlur: UIVisualEffectView!
    
    
    //var iconImageView :UIImageView? = nil
    //var iconImageViewConstraint :Constraint? = nil
    //var titleBgBlurConstraint :Constraint? = nil
    //var titleBgBlurConstraints :Constraint? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBgView.setStyle(shadowRadius :8,shadowOpacity :0.3,cornerRadius :16)
        cellBgInsideView.setStyle(shadowRadius :0,shadowOpacity :0,cornerRadius :16)
        coverImageView.setStyleImage(cornerRadius: 16)
        
        //titleLabel.textDropShadow(positionWidth: 0, positionHeight: 0, shadowRadius: 10, shadowOpacity: 0.8)
        iconViewInside.backgroundColor = UIColor.clear

       //cellBgView.hero.id = "VIEW"

        
       /* iconImageView = UIImageView()
        
        iconImageView?.setStyleImage(cornerRadius: 0)
        
        
        iconImageView?.backgroundColor = UIColor.clear
        iconImageView?.contentMode = .scaleAspectFit
        
        iconImageViewConstraint = iconImageView?.setupConstraint()
    
        
        
        //blurInView?.backgroundColor = UIColor.red
        iconViewInside?.addSubview(iconImageView!)
        
        */
        
    }

}
