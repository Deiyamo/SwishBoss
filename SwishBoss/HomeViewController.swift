//
//  HomeViewController.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import UIKit

class HomeViewController: UIViewController {

    var deliveryTourService: DeliveryTourService = DeliveryTourAPIService() // OR DeliveryTourJSONService
    var deliveryTours: [DeliveryTour] = []
    
    var deliveryTour: DeliveryTour!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        /*let id = 7
        let deliverer = Deliverer(id: 6, firstName: "sym", lastName: "paul", birthDate: "oui", password: "", email: "oui", phone: "oui", profilePicture: Image(url: "oui", height: 20, width: 20), createdDate: Date())
        var parcels = [
            Parcel(id: id, uuid: UUID(), addressStreet: "15 avenue Jean Jaures", town: "Suresnes", zipCode: "92150", country: "France", civility: "", firstname: "", lastname: "", phone: "", email: "", urlProofDelivered: "", isDelivered: false, idTour: 2, order: 3)
        ]
        //let tagsArr = tags.components(separatedBy: ",")*/
        
        
        deliveryTourService.getBy(id: 2) { err, deliveryTour in
            guard err == nil else {
                print("ERROR \(err)")
                return
            }
            
            DispatchQueue.main.async {
                self.deliveryTour = deliveryTour
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = DeliveryToursViewController.newInstance(deliveryTour: self.deliveryTour)
                window.makeKeyAndVisible()
                self.window = window
            }
        }
        
        
        /*self.deliveryTourService.add(deliveryTour: deliveryTour) { error in
            guard error == nil else {
                return
            }
        }
        
        self.deliveryTourService.getAll() { error, tours in
            guard error == nil else {
                return
            }
            print(tours)
        }
        
        self.deliveryTourService.getBy(id: 7) { error, tours in
            guard error == nil else {
                return
            }
            print("GetBy ID:")
            print(tours)
        }
        
        self.deliveryTourService.getBy(delivererName: "Sym PAUl") { error, tours in
            guard error == nil else {
                return
            }
            print("GetBy NAME:")
            print(tours)
        }*/
        
        /*self.deliveryTourService.delete(id: 7) { error in
            guard error == nil else {
                return
            }
        }*/
        
    }

    var window: UIWindow?
}
