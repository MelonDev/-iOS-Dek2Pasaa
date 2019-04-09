import Foundation
import UIKit

struct TestCheck {
    var failed :Bool
    var key :String
    var opened :Bool
    var passed :Bool
    
    
    init(slot :[String :AnyObject]? = nil) {
        if(slot != nil){
            self.failed = slot!["failed"] as! Bool
            self.key = slot!["key"] as! String
            self.opened = slot!["opened"] as! Bool
            self.passed = slot!["passed"] as! Bool
            
            
        }else {
            self.failed = false
            self.key = ""
            self.opened = false
            self.passed = false
            
            
        }
    }
}
