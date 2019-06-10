//
//  VideoTableViewCell.swift
//  Dek2Pasaa
//
//  Created by Android on 10/6/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellViewBtn: UIView!
    @IBOutlet weak var cellViewBtnText: UILabel!
    
    @IBOutlet weak var viewBg: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellViewBtn.layer.cornerRadius = 25

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
