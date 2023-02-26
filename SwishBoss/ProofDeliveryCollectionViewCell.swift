//
//  ProofDeliveryCollectionViewCell.swift
//  SwishBoss
//
//  Created by William Lin on 26/02/2023.
//

import UIKit

class ProofDeliveryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iv_image: UIImageView!
    
    @IBOutlet weak var lb_uuid: UILabel!
    
    @IBOutlet weak var lb_date_delivered: UILabel!
    
    var image : UIImage!
    var uuid : String = ""
    var dateDelivered : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setIvPhoto(image : UIImage){
        self.image = image
        self.iv_image.image = image
    }
    
    public func setLabelUuid(uuid: String){
        self.uuid = uuid
        self.lb_uuid.text = uuid
    }
    
    public func setLabelDateDelivered(date: String){
        self.dateDelivered = date
        self.lb_date_delivered.text = date
    }

}
