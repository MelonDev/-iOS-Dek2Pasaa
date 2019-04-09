
import Foundation
import UIKit

struct WordInfo {
    var cover :String
    var delete :Bool
    var engSound :String
    var key :String
    var masterKey :String
    var nameEng :String
    var nameThai :String
    var number :Int
    var read :String
    var thaiSound :String
    
    init(slot :[String :AnyObject]? = nil) {
        if(slot != nil){
            self.cover = slot!["cover"] as! String
            self.engSound = slot!["engSound"] as! String
            
            //var delete :Bool? = slot!["delete"] as! Bool
            //delete = delete != nil ? delete : false
            
            self.delete = (slot!["delete"] != nil ? slot!["delete"] as! Bool : false)
            self.key = slot!["key"] as! String
            self.masterKey = slot!["masterKey"] as! String
            self.nameEng = slot!["nameEng"] as! String
            self.nameThai = slot!["nameThai"] as! String
            self.number = slot!["number"] as! Int
            self.read = slot!["read"] as! String
            self.thaiSound = slot!["thaiSound"] as! String
        }else {
            self.cover = ""
            self.delete = false
            self.engSound = ""
            self.key = ""
            self.masterKey = ""
            self.nameEng = ""
            self.nameThai = ""
            self.number = 0
            self.read = ""
            self.thaiSound = ""
        }
    }
    
}


