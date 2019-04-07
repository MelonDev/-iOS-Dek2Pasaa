//
//  Constraint.swift
//  Dek2Pasaa
//
//  Created by Android on 29/3/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import Foundation
import UIKit

class Constraint {
    
    var top : NSLayoutConstraint?
    var bottom : NSLayoutConstraint?
    var leading :NSLayoutConstraint?
    var trailing :NSLayoutConstraint?

    var centerX :NSLayoutConstraint?
    var centerY :NSLayoutConstraint?
    var width :NSLayoutConstraint?
    var height :NSLayoutConstraint?

    let view : UIView?
    
    static let topAnchor = "topAnchor"
    static let bottomAnchor = "bottomAnchor"
    static let leadingAnchor = "leadingAnchor"
    static let trailingAnchor = "trailingAnchor"
    static let widthAnchor = "widthAnchor"
    static let heightAnchor = "heightAnchor"
    static let centerXAnchor = "centerXAnchor"
    static let centerYAnchor = "centerYAnchor"
    static let equalWidth = "equalWidth"
    static let equalHeight = "equalHeight"

    
    init(view :UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view = view
    }
    
    func setup(type :String,actionTo :UIView?,value :Int?) {
        
        switch type {
        case Constraint.topAnchor:
            if(top == nil){
                if(actionTo != nil && value != nil){
                    top = view!.topAnchor.constraint(equalTo: actionTo!.topAnchor, constant: CGFloat(value!))
                    top!.isActive = true
                }
            }else {
                update(type: type, value: value)
            }
            break
        case Constraint.bottomAnchor:
            if(bottom == nil){
                if(actionTo != nil && value != nil){
                    bottom = view!.bottomAnchor.constraint(equalTo: actionTo!.bottomAnchor, constant: CGFloat(0 - value!))
                    bottom!.isActive = true
                    
                }
            }else {
                update(type: type, value: value)
            }
            break
        case Constraint.leadingAnchor:
            if(leading == nil){
                if(actionTo != nil && value != nil){
                    leading = view!.leadingAnchor.constraint(equalTo: actionTo!.leadingAnchor, constant: CGFloat(value!))
                    leading!.isActive = true
                    
                }
            }else {
                update(type: type, value: value)
            }
            break
        case Constraint.trailingAnchor:
            if(trailing == nil){
                if(actionTo != nil && value != nil){
                    trailing = view!.trailingAnchor.constraint(equalTo: actionTo!.trailingAnchor, constant: CGFloat(0 - value!))
                    trailing!.isActive = true
                    
                }
            }else {
                update(type: type, value: value)
            }
            break
        case Constraint.widthAnchor:
            if(width == nil){
                if(value != nil){
                    width = view!.widthAnchor.constraint(equalToConstant: CGFloat(value!))
                    width!.isActive = true
                    
                }
            }else {
                update(type: type, value: value)
            }
            break
        case Constraint.heightAnchor:
            if(height == nil){
                if(value != nil){
                    height = view!.heightAnchor.constraint(equalToConstant: CGFloat(value!))
                    height!.isActive = true
                    
                }
            }else {
                update(type: type, value: value)
            }
            break
            
        case Constraint.equalHeight:
            if(height == nil){
                if(value != nil){
                    height = view!.heightAnchor.constraint(equalTo: actionTo!.heightAnchor, multiplier: 1.0)
                    height!.isActive = true
                    
                }
            }else {
                update(type: type, value: value)
            }
            break
        case Constraint.equalWidth:
            if(width == nil){
                if(value != nil){
                    width = view!.widthAnchor.constraint(equalTo: actionTo!.widthAnchor, multiplier: 1.0)
                    width!.isActive = true
                    
                }
            }else {
                update(type: type, value: value)
            }
            break
            
        case Constraint.centerXAnchor:
            if(centerX == nil){
                if(actionTo != nil){
                    centerX = view!.centerXAnchor.constraint(equalTo: actionTo!.centerXAnchor)
                    centerX!.isActive = true
                    
                }
            }else {
                update(type: type, value: value)
            }
            break
    
        case Constraint.centerYAnchor:
            if(centerY == nil){
                if(actionTo != nil){
                    centerY = view!.centerYAnchor.constraint(equalTo: actionTo!.centerYAnchor)
                    centerY!.isActive = true
                    
                }
            }else {
                update(type: type, value: value)
            }
            break
        default:
            print()
        }
        
    }
    
    func update(type :String,value :Int?) {
        switch type {
            case Constraint.topAnchor:
                if(value != nil){
                top!.constant = CGFloat(value!)
            }
                break
            case Constraint.bottomAnchor:
                if(value != nil){
                    bottom!.constant = CGFloat(value!)
                }
            break
            case Constraint.leadingAnchor:
                if(value != nil){
                    leading!.constant = CGFloat(value!)
                }
            break
            case Constraint.trailingAnchor:
                if(value != nil){
                    trailing!.constant = CGFloat(value!)
                }
            break
            case Constraint.widthAnchor:
                if(value != nil){
                    width!.constant = CGFloat(value!)
                }
            break
            case Constraint.heightAnchor:
                if(value != nil){
                    height!.constant = CGFloat(value!)
                }
            break
            default:
            print()
        }
    }
    
    
    
    
    
    
}
