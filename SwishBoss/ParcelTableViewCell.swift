//
//  ParcelTableViewCell.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 22/02/2023.
//

import UIKit
import CoreLocation

class ParcelTableViewCell: UITableViewCell {

    @IBOutlet weak var labelFullName: UILabel!
    @IBOutlet weak var labelAddressStreet: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelDelivery: UILabel!
    @IBOutlet weak var labelDateDelivery: UILabel!
    @IBOutlet weak var iconParcel: UIImageView!
    var parcel: Parcel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func redraw(parcel: Parcel, delivererPosition: CLLocationCoordinate2D) {
        self.parcel = parcel
        labelFullName.text = "\(parcel.civility) \(parcel.firstname) \(parcel.lastname)"
        labelAddressStreet.text = "\(parcel.addressStreet), \(parcel.zipCode) \(parcel.town)"
        
        if parcel.isDelivered {
            showDeliveredInformations()
            iconParcel.image = UIImage(systemName: "cube.box.fill")
            iconParcel.tintColor = .systemGreen
        } else {
            labelDelivery.isHidden = true
            labelDateDelivery.isHidden = true
            iconParcel.image = UIImage(systemName: "box.truck.badge.clock.fill")
            iconParcel.tintColor = .systemOrange
            updateDistance(delivererPosition: delivererPosition)
        }
    }
    
    
    
    fileprivate func showDeliveredInformations() {
        labelDelivery.isHidden = false
        labelDateDelivery.isHidden = false
        
        let getFormatter = DateFormatter()
        getFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.000Z'"
        let printFormatter = DateFormatter()
        printFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        if let date = getFormatter.date(from: parcel.dateDelivered!) {
            labelDateDelivery.text = printFormatter.string(from: date)
        } else {
            labelDateDelivery.text = "Erreur format de date"
        }
        labelDistance.text = "Livré"
    }
    
    
    fileprivate func updateDistance(delivererPosition: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("\(parcel.addressStreet) \(parcel.zipCode) \(parcel.town) \(parcel.country)") { placemmarks, err in
            guard let placemmarks = placemmarks else {
                return
            }
            
            if let coordinate = placemmarks.last?.location?.coordinate {
                let myLocation = CLLocation(latitude: delivererPosition.latitude, longitude: delivererPosition.longitude)
                let parcelLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                let distance = myLocation.distance(from: parcelLocation)
                if distance >= 1000 {
                    let distanceStr = String(format: "%.2f", distance / 1000)
                    self.labelDistance.text = "\(distanceStr) km"
                } else {
                    let distanceStr = String(format: "%.2f", distance)
                    self.labelDistance.text = "\(distanceStr) m"
                }
                
            } else {
                self.labelDistance.text = "Distance inconnue"
            }
        }
        
    }
    
}
