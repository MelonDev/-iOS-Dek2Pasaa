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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBgView.setStyle(shadowRadius :8,shadowOpacity :0.3,cornerRadius :16)
        cellBgInsideView.setStyle(shadowRadius :0,shadowOpacity :0,cornerRadius :16)
        coverImageView.setStyleImage(cornerRadius: 16)
        
    }

}
