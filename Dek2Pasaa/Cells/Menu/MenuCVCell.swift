//
//  MenuCVCell.swift
//  Dek2Pasaa
//
//  Created by Android on 25/3/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import UIKit

class MenuCVCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var cellBgInsideView: UIView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBgView.setStyle()
        cellBgInsideView.setStyle(shadowRadius :0,shadowOpacity :0,cornerRadius :12)
        
    }

}
