//
//  DelivererCollectionViewCell.swift
//  SwishBoss
//
//  Created by William Lin on 23/02/2023.
//

import UIKit

class DelivererCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivPhoto: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var lbFirstname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ivPhoto.contentMode = .scaleAspectFit
//        self.ivPhoto.layer.cornerRadius = self.ivPhoto.frame.size.width / 2
//        self.ivPhoto.layer.cornerRadius = self.ivPhoto.frame.size.width / 2
        self.ivPhoto.clipsToBounds = true
        self.backgroundColor = UIColor(red: 31.0/255, green: 39.0/255, blue: 49.0/255, alpha: 1)
        
    }
    
    var image : UIImage!
    var name : String = ""
    var firstname : String = ""
    
    public func setIvPhoto(image : UIImage){
        self.image = image
        self.ivPhoto.image = image
    }
    
    public func setLabelName(name: String){
        self.name = name
        self.lbName.text = name
    }
    
    public func setLabelFirstname(firstname: String){
        self.firstname = firstname
        self.lbFirstname.text = firstname
    }

}
