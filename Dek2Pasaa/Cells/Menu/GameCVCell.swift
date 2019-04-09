
import UIKit

class GameCVCell: UICollectionViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleViewBg: UIView!
    @IBOutlet weak var visualBg: UIVisualEffectView!
    @IBOutlet weak var unknownLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //viewBG.setStyle()
        viewBG.backgroundColor = UIColor.clear
        
        unknownLabel.isHidden = true
        
        viewBG.layer.cornerRadius = 16
        imageView.layer.cornerRadius = 16
        
        
        titleViewBg.backgroundColor = UIColor.clear
       
        
        titleViewBg.layer.cornerRadius = 16
        visualBg.contentView.layer.cornerRadius = 16
        visualBg.layer.cornerRadius = 16
        visualBg.clipsToBounds = true


        if #available(iOS 11.0, *) {
            titleViewBg.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            visualBg.contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
             visualBg.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
 
        }
 
        
        
    }

}
