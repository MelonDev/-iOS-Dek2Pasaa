//
//  LessonTableViewCell.swift
//  Dek2Pasaa
//
//  Created by Android on 13/4/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import UIKit

class LessonTableViewCell: UITableViewCell {

    @IBOutlet weak var circleA: UIView!
    @IBOutlet weak var circleB: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        circleA.layer.cornerRadius = 20
        circleB.layer.cornerRadius = 20

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
