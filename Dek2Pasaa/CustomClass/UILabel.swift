//
//  UILabel.swift
//  Dek2Pasaa
//
//  Created by Android on 25/3/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func fontSize(size :Int){
        font = font.withSize(CGFloat(size))
    }
    
    func textDropShadow(maskToBound :Bool = false,positionWidth :Int,positionHeight :Int,shadowRadius :Float,shadowOpacity :Float,color :UIColor = UIColor.black) {
        layer.masksToBounds = maskToBound
        layer.shadowRadius = CGFloat(shadowRadius)
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: positionWidth, height: positionHeight)
        
        layer.shadowColor = color.cgColor
    }
    
}
