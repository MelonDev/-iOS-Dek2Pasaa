//
//  TestStarCVCell.swift
//  Dek2Pasaa
//
//  Created by Android on 10/4/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import UIKit

class TestStarCVCell: UICollectionViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBg.layer.cornerRadius = 16
    }

}
