//
//  SettingTableViewCell.swift
//  Dek2Pasaa
//
//  Created by Android on 17/4/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var subContentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        content.backgroundColor = UIColor.clear
        subContentView.layer.cornerRadius = 10
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
