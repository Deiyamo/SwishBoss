//
//  HomeViewController.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import UIKit

class HomeViewController: UIViewController {

    var deliveryTourService: DeliveryTourService = DeliveryTourJSONService() // OR ()
    var deliveryTours: [DeliveryTour] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let address = Address(num: "15", street: "av jj", city: "paris", zipCode: "75011", country: "France")
        
        let id = 11
        let deliverer = Deliverer(id: 1, firstName: "jean", lastName: "bob", birthDate: "oui", password: "", email: "oui", phone: "oui", profilePicture: Image(url: "oui", height: nil, width: nil), createdDate: Date())
        var parcels = [Parcel(uuid: "uuid:)", deliveryAddress: address, billAddress: address, createdDate: Date(), clientName: "William le livreur tutuuut")]
        //let tagsArr = tags.components(separatedBy: ",")
        let deliveryTour = DeliveryTour(id: id, deliverer: deliverer, parcels: parcels, deliveryDate: Date())
        self.deliveryTourService.add(deliveryTour: deliveryTour) { error in
            guard error == nil else {
                return
            }
        }
    }


}
