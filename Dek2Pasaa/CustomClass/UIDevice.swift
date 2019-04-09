import UIKit

public extension UIDevice {
    
    func isIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    func isPortrait() -> Bool {
        /*  switch UIDevice.current.orientation{
         case .portrait:
         return true
         case .portraitUpsideDown:
         return true
         case .landscapeLeft:
         return false
         case .landscapeRight:
         return false
         default:
         return true
         }
         */
        
        let size = UIScreen.main.bounds.size
        if size.width < size.height {
            return true
        } else {
            return false
        }
        
        //return UIDevice.current.orientation.isPortrait
    }
    
    
    
    func isPortraitUpsideDown() -> Bool {
        if(isPortrait()){
            switch UIDevice.current.orientation{
            case .portrait:
                return false
            case .portraitUpsideDown:
                return true
            default:
                return false
            }
            
        } else {
            return false
        }
    }
    
    func isLandscape() -> Bool {
        /*
         switch UIDevice.current.orientation{
         case .portrait:
         return false
         case .portraitUpsideDown:
         return false
         case .landscapeLeft:
         return true
         case .landscapeRight:
         return true
         default:
         return false
         }
         */
        //return UIDevice.current.orientation.isLandscape
        let size = UIScreen.main.bounds.size
        if size.width < size.height {
            return false
        } else {
            return true
        }
    }
    
    func isLandscapeLeft() -> Bool {
        if(isLandscape()){
            switch UIDevice.current.orientation{
            case .landscapeLeft:
                return true
            case .landscapeRight:
                return false
            default:
                return false
            }
        }else {
            return false
        }
    }
    
    func isLandscapeRight() -> Bool {
        if(isLandscape()){
            switch UIDevice.current.orientation{
            case .landscapeLeft:
                return false
            case .landscapeRight:
                return true
            default:
                return false
            }
        }else {
            return false
        }
    }
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
    static let isNotch: Bool = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> Bool {
            //#if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return false
            case "iPod7,1":                                 return false
            case "iPhone7,2":                               return false
            case "iPhone7,1":                               return false
            case "iPhone8,1":                               return false
            case "iPhone8,2":                               return false
            case "iPhone9,1", "iPhone9,3":                  return false
            case "iPhone9,2", "iPhone9,4":                  return false
            case "iPhone8,4":                               return false
            case "iPhone10,1", "iPhone10,4":                return false
            case "iPhone10,2", "iPhone10,5":                return false
            case "iPad4,1", "iPad4,2", "iPad4,3":           return false
            case "iPad5,3", "iPad5,4":                      return false
            case "iPad6,11", "iPad6,12":                    return false
            case "iPad7,5", "iPad7,6":                      return false
            case "iPad2,5", "iPad2,6", "iPad2,7":           return false
            case "iPad4,4", "iPad4,5", "iPad4,6":           return false
            case "iPad4,7", "iPad4,8", "iPad4,9":           return false
            case "iPad5,1", "iPad5,2":                      return false
            case "iPad6,3", "iPad6,4":                      return false
            case "iPad6,7", "iPad6,8":                      return false
            case "iPad7,1", "iPad7,2":                      return false
            case "iPad7,3", "iPad7,4":                      return false
            case "i386", "x86_64":                          return false
            default:                                        return true
            }
            
            //#endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
    static let isFourInch: Bool = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> Bool {
            //#if os(iOS)
            
            var iden = identifier
            
            if iden.contains("i386") || iden.contains("x86_64"){
                iden = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"
            }
            
            
            switch iden {
            case "iPod5,1":                                 return true
            case "iPod7,1":                                 return true
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return true
            case "iPhone4,1":                               return true
            case "iPhone5,1", "iPhone5,2":                  return true
            case "iPhone5,3", "iPhone5,4":                  return true
            case "iPhone6,1", "iPhone6,2":                  return true
            case "iPhone8,4":                               return true
            default:                                        return false
            }
            
            
            //#endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
    static func hasNotch() -> Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            //print(bottom)
            return bottom > 0
            
        } else {
            return false
        }
    }
    
    static func topSafeArea() -> CGFloat{
        if #available(iOS 11.0, *) {
            let top = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
            return top
        }else {
            return 0
        }
    }
    
    static func bottomSafeArea() -> CGFloat{
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            //print("bottom \(bottom)")
            return bottom
        }else {
            return 0
        }
    }
    
    static func leftSafeArea() -> CGFloat{
        if #available(iOS 11.0, *) {
            let left = UIApplication.shared.keyWindow?.safeAreaInsets.left ?? 0
            return left
        }else {
            return 0
        }
    }
    
    static func rightSafeArea() -> CGFloat{
        if #available(iOS 11.0, *) {
            let right = UIApplication.shared.keyWindow?.safeAreaInsets.right ?? 0
            return right
        }else {
            return 0
        }
    }
    
    func inspectDeviceOrientation() {
        let orientation = UIDevice.current.orientation
        switch UIDevice.current.orientation {
        case .portrait:
            print("portrait")
        case .landscapeLeft:
            print("landscapeLeft")
        case .landscapeRight:
            print("landscapeRight")
        case .portraitUpsideDown:
            print("portraitUpsideDown")
        case .faceUp:
            print("faceUp")
        case .faceDown:
            print("faceDown")
        default: // .unknown
            print("unknown")
        }
        if orientation.isPortrait { print("isPortrait") }
        if orientation.isLandscape { print("isLandscape") }
        if orientation.isFlat { print("isFlat") }
    }
    
}
