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
            let json = try JSONSerialization.jsonObject(with: data)
            guard let dicts = json as? [ [String: Any] ] else {
                completion([])
                return
            }
            completion(dicts.compactMap { dict in
                return DeliveryTour.fromDictionary(dict: dict)
            })
        } catch {
            completion([])
        }
    }
    
    fileprivate func writeDeliveryTours(deliveryTours: [DeliveryTour], completion: @escaping (Error?) -> Void) {
        let dicts = deliveryTours.map { deliveryTour in
            return deliveryTour.toDictionary()
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dicts, options: .fragmentsAllowed)
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
    
    func getBy() {
        
    }
    
    func getAll(_ completion: @escaping (Error?, [DeliveryTour]?) -> Void) {
        
    }
    
    func update() {
        
    }
    
    func delete(_ completion: @escaping (Error?) -> Void) {
        
    }
    
}
