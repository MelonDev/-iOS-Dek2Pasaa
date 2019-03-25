
import UIKit

extension UIButton {
    
    func buttonStyle(radius :Int) {
        layer.masksToBounds = false
        layer.cornerRadius = CGFloat(radius)
    }
    
}
