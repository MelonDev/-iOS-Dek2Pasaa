
import Foundation
import UIKit

struct LessonInfo {
    var cover :String
    var delete :Bool
    var key :String
    var nameEng :String
    var nameThai :String
    var number :Int
    var price :Double
    var status :String
    var type :String
    
    init(slot :[String :AnyObject]? = nil) {
        if(slot != nil){
            self.cover = slot!["cover"] as! String
            self.delete = slot!["delete"] as! Bool
            self.key = slot!["key"] as! String
            self.nameEng = slot!["nameEng"] as! String
            self.nameThai = slot!["nameThai"] as! String
            self.number = slot!["number"] as! Int
            self.price = slot!["price"] as! Double
            self.status = slot!["status"] as! String
            self.type = slot!["type"] as! String
        }else {
            self.cover = ""
            self.delete = false
            self.key = ""
            self.nameEng = ""
            self.nameThai = ""
            self.number = 0
            self.price = 0.0
            self.status = ""
            self.type = ""
        }
    }
    
}
