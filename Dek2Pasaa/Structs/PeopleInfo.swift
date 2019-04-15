//
//  PeopleInfo.swift
//  Dek2Pasaa
//
//  Created by Android on 15/4/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import Foundation

struct PeopleInfo {
    var name :String? = nil
    var score :Int? = nil
    var key :String? = nil
    var image :String? = nil
    
    init(slot :[String :AnyObject]? = nil) {
        if(slot != nil){
            self.name = slot!["name"] as? String
            self.score = slot!["score"] as? Int
            
            self.key = slot!["key"] as? String
            self.image = slot!["image"] as? String
           
        }else {
            self.name = ""
            self.score = 0
            self.image = ""
            self.key = ""
            
        }
    }
}
