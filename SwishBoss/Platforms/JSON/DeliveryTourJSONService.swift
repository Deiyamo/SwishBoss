//
//  DeliveryTourJSONService.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

class DeliveryTourJSONService: DeliveryTourService {

    var filePath: String
    
    init() {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        self.filePath = "file://\(directories[0].appending("/delivery_tours.json"))"
        print(directories)
    }
    
    fileprivate func readDeliveryTours(_ completion: @escaping ([DeliveryTour]) -> Void) {
        do {
            let data = try Data(contentsOf: URL(string: self.filePath)!)
            // transform json file content in [DeliveryTour]
            let jsonData = try JSONDecoder().decode([DeliveryTour].self, from: data)
            
            completion(jsonData)
        } catch {
            completion([])
        }
    }
    
    fileprivate func writeDeliveryTours(deliveryTours: [DeliveryTour], completion: @escaping (Error?) -> Void) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted] // .sortedKeys
            
            let jsonData = try encoder.encode(deliveryTours)
            try jsonData.write(to: URL(string: self.filePath)!)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    
    
    
    func add(deliveryTour: DeliveryTour, _ completion: @escaping (Error?) -> Void) {
        self.readDeliveryTours { deliveryTours in
            var newTours = deliveryTours
            newTours.append(deliveryTour)
            self.writeDeliveryTours(deliveryTours: newTours, completion: completion)
        }
    }
    
    func getBy(id: Int, _ completion: @escaping (Error?, [DeliveryTour]?) -> Void) {
        self.readDeliveryTours { deliveryTours in
            let tours = deliveryTours.filter { tours in
                return tours.id == id
            }
            completion(nil, tours)
        }
    }
    
    func getBy(delivererName: String, _ completion: @escaping (Error?, [DeliveryTour]?) -> Void) {
//        self.readDeliveryTours { deliveryTours in
//            let tours = deliveryTours.filter { tours in
////                let deliverer = "\(tours.deliverer.firstname) \(tours.deliverer.name)".lowercased()
//                return deliverer.contains(delivererName.lowercased())
//            }
//            completion(nil, tours)
//        }
    }
    
    func getAll(_ completion: @escaping (Error?, [DeliveryTour]?) -> Void) {
        self.readDeliveryTours { deliveryTours in
            completion(nil, deliveryTours)
        }
    }
    
    func update() {
        
    }
    
    func delete(id: Int, _ completion: @escaping (Error?) -> Void) {
        self.readDeliveryTours { deliveryTours in
            var updatedTours = deliveryTours
            for(index, item) in updatedTours.enumerated() {
                if (item.id == id) {
                    updatedTours.remove(at: index)
                }
            }
        }
    }
    
}
