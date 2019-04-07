import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
    }
    
    func newRoundCorners(width :CGFloat,height :CGFloat, corners: UIRectCorner, radius: CGFloat) {
        
        print(frame.width)
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = frame
        //let a = rectShape.bounds
        //rectShape.bounds.width = width
        //rectShape.bounds.height = height
        rectShape.position = center
        rectShape.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        
        //layer.backgroundColor = UIColor.green.cgColor
        //Here I'm masking the textView's layer with rectShape layer
        layer.mask = rectShape
        
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
    
    func setAdvanceStyle(maskToBound :Bool = false,shadowRadius :Float,shadowOpacity :Float,positionWidth :Int,positionHeight :Int,cornerRadius :Float) {
        layer.masksToBounds = maskToBound
        layer.shadowOffset = CGSize(width: positionWidth, height: positionHeight)
        layer.shadowRadius = CGFloat(shadowRadius)
        layer.shadowOpacity = shadowOpacity
        layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    func onClick(tap :UITapGestureRecognizer){
        addGestureRecognizer(tap)
    }
    
    func onClick(tap :UITapGestureRecognizer,view :UIView){
        view.addGestureRecognizer(tap)
    }
    
    func topAnchor(mainView :UIView,length :Int) {
        //let margin = mainView.layoutMarginsGuide
        print(topAnchor)

        //topAnchor.constraint(equalTo: margin.topAnchor, constant: CGFloat(length)).isActive = true
        
        topAnchor.constraint(equalTo: mainView.topAnchor, constant: CGFloat(length)).isActive = true
    }
    
    func bottomAnchor(mainView :UIView,length :Int) {
        //let margin = mainView.layoutMarginsGuide

        bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: CGFloat(length)).isActive = true
    }
    
    func leadingAnchor(mainView :UIView,length :Int) {
        //let margin = mainView.layoutMarginsGuide
        leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: CGFloat(length)).isActive = true
        
      
    }
    
    func trailingAnchor(mainView :UIView,length :Int) {
        //let margin = mainView.layoutMarginsGuide

        trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: CGFloat(length)).isActive = true
    }
    
    func configConstraints(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func widthAnchor(length :Int) {
        widthAnchor.constraint(equalToConstant: CGFloat(length)).isActive = true
    }
    
    func heightAnchor(length :Int) {
        heightAnchor.constraint(equalToConstant: CGFloat(length)).isActive = true
    }
    
    func centerXAnchor(mainView :UIView,length :Int) {
        centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
    }
    
    func centerYAnchor(mainView :UIView,length :Int) {
        centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
    }
    
    func anchor(mainView :UIView ,top :Int?,bottom :Int?,leading :Int?,trailing :Int?) {
        if(top != nil){
            topAnchor(mainView: mainView, length: top!)
        }
        if(bottom != nil){
            bottomAnchor(mainView: mainView, length: bottom!)
        }
        if(leading != nil){
            leadingAnchor(mainView: mainView, length: leading!)
        }
        if(trailing != nil){
            trailingAnchor(mainView: mainView, length: trailing!)
        }
        
    }
    
    func setupConstraint() -> Constraint {
        return Constraint(view: self)
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

