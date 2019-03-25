import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func hideWithAnimation(duration :Float = 0.2,delay :Float = 0){
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), options: [], animations: {
            self.alpha = 0
        }, completion: {_ in
            self.isHidden = true
        })
    }
    
    func showWithAnimation(duration :Float = 0.2,delay :Float = 0){
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), options: [], animations: {
            self.alpha = 1
        }, completion: { _ in
            self.isHidden = false
        })
    }
    
    func setStyle()  {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.4
        layer.cornerRadius = 16
    }
    
    func setStyleWithOutShadow(viewLayer :UIView,cornerRadius :Float) {
        layer.masksToBounds = false
        layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    func setStyle(shadowRadius :Float,shadowOpacity :Float,cornerRadius :Float) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = CGFloat(shadowRadius)
        layer.shadowOpacity = shadowOpacity
        layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    func onClick(tap :UITapGestureRecognizer){
        addGestureRecognizer(tap)
    }
    
}

extension CACornerMask {
    
    
    func topLeft() -> CACornerMask {
        return CACornerMask.layerMinXMinYCorner
    }
    
    func topRight() -> CACornerMask {
        return CACornerMask.layerMaxXMinYCorner
    }
    
    func bottomLeft() -> CACornerMask {
        return CACornerMask.layerMinXMaxYCorner
    }
    
    func bottomRight() -> CACornerMask {
        return CACornerMask.layerMaxXMaxYCorner
    }
    
    
}

