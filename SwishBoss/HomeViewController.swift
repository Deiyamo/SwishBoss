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
        if(Token.token == ""){
           
            let loginViewController = LoginViewController()

            self.navigationController?.pushViewController(loginViewController, animated: true)
        }else{
//            let address = Address(num: "15", street: "av jj", city: "paris", zipCode: "75011", country: "France")
//
//            let id = 11
//            let deliverer = Deliverer(id: 1, firstName: "jean", lastName: "bob", birthDate: "oui", password: "", email: "oui", phone: "oui", profilePicture: Image(url: "oui", height: nil, width: nil), createdDate: Date())
//            var parcels = [Parcel(uuid: "uuid:)", deliveryAddress: address, billAddress: address, createdDate: Date(), clientName: "William le livreur tutuuut")]
//            //let tagsArr = tags.components(separatedBy: ",")
//            let deliveryTour = DeliveryTour(id: id, deliverer: deliverer, parcels: parcels, deliveryDate: Date())
//            self.deliveryTourService.add(deliveryTour: deliveryTour) { error in
//                guard error == nil else {
//                    return
//                }
//            }
        }
        
//        self.deliveryTourService.getAll() { error, tours in
//            guard error == nil else {
//                return
//            }
//            print(tours)
//        }
//
//        self.deliveryTourService.getBy(id: 7) { error, tours in
//            guard error == nil else {
//                return
//            }
//            print("GetBy ID:")
//            print(tours)
//        }
//
//        self.deliveryTourService.getBy(delivererName: "Sym PAUl") { error, tours in
//            guard error == nil else {
//                return
//            }
//            print("GetBy NAME:")
//            print(tours)
//        }
        
        /*self.deliveryTourService.delete(id: 7) { error in
            guard error == nil else {
                return
            }
        }*/
    }
    
    
    @IBAction func btnGoToDelivererVC(_ sender: Any) {
        DelivererWebService.getItems(){err, success in
            guard err == nil else {
                print(err)
                return
            }
            guard (success != nil) else {
                return
            }
            DispatchQueue.main.async {
                //print(success)
                let delivererViewController = DelivererViewController.newInstance(deliverers: success!)
                self.navigationController?.pushViewController(delivererViewController, animated: true)
            }
            
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }


}
