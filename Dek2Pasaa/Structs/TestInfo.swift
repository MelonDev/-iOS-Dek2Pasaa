
import Foundation
import UIKit

struct TestInfo {
    var ansOne :String
    var ansTwo :String
    var delete :Bool
    var answer :Int
    var cover :String
    var key :String
    var masterKey :String
    var number :Int
    var quesEng :String
    var quesThai :String
    var skill :String

    
    init(slot :[String :AnyObject]? = nil) {
        if(slot != nil){
            self.ansOne = slot!["ansOne"] as! String
            self.ansTwo = slot!["ansTwo"] as! String
            self.answer = slot!["answer"] as! Int
            self.cover = slot!["cover"] as! String

            
            self.delete = (slot!["delete"] != nil ? slot!["delete"] as! Bool : false)
            
            self.key = slot!["key"] as! String
            self.masterKey = slot!["masterKey"] as! String
            self.quesEng = slot!["quesEng"] as! String
            self.quesThai = slot!["quesThai"] as! String
            self.number = slot!["number"] as! Int
            self.skill = (slot!["skill"] != nil ? slot!["skill"] as! String : "")

        }else {
            self.cover = ""
            self.delete = false
            self.ansOne = ""
            self.ansTwo = ""

            
            self.key = ""
            self.masterKey = ""
            self.quesEng = ""
            self.quesThai = ""
            self.number = 0
            self.answer = 0

            self.skill = ""
        }
    }
    
}



