//
//  DeliveryToursViewController.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 22/02/2023.
//

import UIKit
import CoreLocation
import MapKit

class DeliveryToursViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var deliveryToursTableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var timer: Timer?
    
    var deliveryTourService: DeliveryTourService = DeliveryTourAPIService() // OR ()
    var deliveryTour: DeliveryTour!
    
    // 48.866991689078894, 2.3341856827099856
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(48.866991689078894), longitude: CLLocationDegrees(2.3341856827099856)), latitudinalMeters: 20000, longitudinalMeters: 20000), animated: true)
        
        let parcelsCellNib = UINib(nibName: "ParcelTableViewCell", bundle: nil)
        self.deliveryToursTableView.register(parcelsCellNib, forCellReuseIdentifier: "PARCEL")
        self.deliveryToursTableView.dataSource = self
        self.deliveryToursTableView.delegate = self
        self.deliveryToursTableView.rowHeight = 90.0
        
        addMarkerParcels()
        addMarkerDeliverer()
        
        
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.handleMoveUser), userInfo: nil, repeats: true)
        
        deliveryTourService.getAll() { error, tours in
            print("HERE")
            guard error == nil else {
                print(error)
                return
            }
            print("TOURS")
            print(tours)
        }
        
    }
    
    
    
    
    class func newInstance(deliveryTour: DeliveryTour) -> DeliveryToursViewController {
        let controller = DeliveryToursViewController()
        controller.deliveryTour = deliveryTour
        controller.deliveryTour.parcels.sorted { $0.order! < $1.order! }
        return controller
    }
    
    
    func addMarkerParcels() {
        let parcels = self.deliveryTour.parcels
        
        
        parcels.forEach { parcel in
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString("\(parcel.addressStreet) \(parcel.zipCode) \(parcel.town) \(parcel.country)") { placemmarks, err in
                guard let placemmarks = placemmarks else {
                    return
                }
                
                let marker = MKPointAnnotation()
                marker.coordinate = (placemmarks.last?.location?.coordinate)!
                marker.title = "Colis"
                marker.subtitle = "\(parcel.civility) \(parcel.firstname) \(parcel.lastname)"
                self.mapView.addAnnotation(marker)
            }
        }
        
    }
    
    func addMarkerDeliverer() {
        let deliverer = self.deliveryTour.deliverer
        
        // 242 Rue du Faubourg Saint-Antoine 75012 Paris"
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: CLLocationDegrees(deliverer!.currentLatitude!), longitude: CLLocationDegrees(deliverer!.currentLongitude!))) { placemmarks, err in
            guard let placemmarks = placemmarks else {
                return
            }
            
            let marker = MKPointAnnotation()
            
            marker.coordinate = (placemmarks.last?.location?.coordinate)!
            marker.title = "Livreur"
            marker.subtitle = "\(deliverer?.firstname ?? "") \(deliverer?.name ?? "")"
            self.mapView.addAnnotation(marker)
        }
    }
    
    func resetAnnotations() {
        let annotations = mapView.annotations.filter {
                $0 !== self.mapView.userLocation
        }
        mapView.removeAnnotations(annotations)
    }
    
    
    @IBAction func deleteTourButton(_ sender: Any) {
        AlertMessages.show(message: "Êtes-vous sûr de vouloir supprimer cette tournée ?", parent: self)
        // TODO: if oui delete()
    }
    
    
    @objc func handleMoveUser() {
        deliveryTourService.getBy(id: 2) { err, deliveryTour in
            guard err == nil else {
                print("ERROR \(err)")
                return
            }
            
            DispatchQueue.main.async {
                self.deliveryTour = deliveryTour
                self.deliveryToursTableView.reloadData()
            }
        }
        
        resetAnnotations()
        addMarkerParcels()
        addMarkerDeliverer()
        
    }
    
}



extension DeliveryToursViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinAnnotation = self.mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        pinAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        
        pinAnnotation?.canShowCallout = true // affiche la popup quand on clique sur le pin
        
        switch annotation.title {
        case "Livreur":
            pinAnnotation?.image = UIImage(systemName: "box.truck.fill")
        case "Colis":
            pinAnnotation?.image = UIImage(systemName: "cube.box.fill")
        default:
            break
        }
        
        return pinAnnotation
    }
}


extension DeliveryToursViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deliveryTour.parcels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let parcel = self.deliveryTour.parcels[indexPath.row]
        let deliverer = self.deliveryTour.deliverer
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PARCEL", for: indexPath) as! ParcelTableViewCell
        let delivererPosition = CLLocationCoordinate2D(latitude: CLLocationDegrees(deliverer!.currentLatitude!), longitude: CLLocationDegrees(deliverer!.currentLongitude!))
        cell.redraw(parcel: parcel, delivererPosition: delivererPosition)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parcel = deliveryTour.parcels[indexPath.row]
        var controller = InfoParcelViewController.newInstance(parcel: parcel)
        controller.title = "\(parcel.firstname) \(parcel.lastname)"
        controller.modalPresentationStyle = .automatic
        self.present(UINavigationController(rootViewController: controller), animated: true)
    }
    
}
