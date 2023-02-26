//
//  ToursTableViewCell.swift
//  SwishBoss
//
//  Created by William Lin on 25/02/2023.
//

import UIKit

class ToursTableViewCell: UITableViewCell {

    @IBOutlet weak var lb_status: UILabel!
    
    @IBOutlet weak var lb_deliveryDate: UILabel!
    
    @IBOutlet weak var lb_deliverer: UILabel!
    
    var status : String = ""
    var deliveryDate : String = "Date de livraison : "
    var name : String = ""
    var firstname : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func setLabelStatus(status: String){
        self.status = status
        if(status == "not started"){
            self.lb_status.backgroundColor = UIColor(red: 255.0/255, green: 45.0/255, blue: 85.0/255, alpha: 1)
        }else if(status == "In process"){
            self.lb_status.backgroundColor = UIColor(red: 255.0/255, green: 149.0/255, blue: 0.0/255, alpha: 1)
        }else{
            self.lb_status.backgroundColor = UIColor(red: 52.0/255, green: 199.0/255, blue: 89.0/255, alpha: 1)
        }
        self.lb_status.text = status
    }
    
    public func setLabelDeliveryDate(date: String){
        self.deliveryDate = "Date de livraison : " + date
        self.lb_deliveryDate.text = self.deliveryDate
    }
    
    public func setLabelDeliverer(name: String, firstname: String){
        self.name = name
        self.firstname = firstname
        self.lb_deliverer.text = "Livreur : \(name) \(firstname)"
    }
    
}
