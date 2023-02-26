//
//  DeliveryTourAPIService.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 25/02/2023.
//

import Foundation

class DeliveryTourAPIService: DeliveryTourService {
    
    func add(deliveryTour: DeliveryTour, _ completion: @escaping (Error?) -> Void) {
        
    }
    
    func getAll(_ completion: @escaping (Error?, [DeliveryTour]?) -> Void) {
        let request = APIRequest.get(url: "/tours")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard let d = data else {
                completion(NSError(domain: "com.timdev.SwishBoss", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), nil)
                return
            }
            
            do {
                let obj = try JSONDecoder().decode([DeliveryTour].self, from: d)
                
                completion(nil, obj)
            } catch let err {
                completion(err, nil)
                return
            }
            
        }
        task.resume()
    }
    
    func getBy(id: Int, _ completion: @escaping (Error?, DeliveryTour?) -> Void) {
        let request = APIRequest.get(url: "/tours/\(id)")
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard let d = data else {
                completion(NSError(domain: "com.timdev.SwishBoss", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]), nil)
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(DeliveryTour.self, from: d)

                completion(nil, obj)
            } catch let err {
                completion(err, nil)
                return
            }

        }
        task.resume()
    }
    
    func getBy(delivererName: String, _ completion: @escaping (Error?, [DeliveryTour]?) -> Void) {
        
    }
    
    func update() {
        
    }
    
    func delete(id: Int, _ completion: @escaping (Error?) -> Void) {
        let request = APIRequest.put(url: "/tours/\(id)", body: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, res, err in
            guard let d = data else {
                completion(NSError(domain: "com.timdev.SwishBoss", code: 2, userInfo: [
                    NSLocalizedFailureReasonErrorKey: "No data found"
                ]))
                return
            }
            
            do {
                completion(nil)
            } catch let err {
                completion(err)
                return
            }

        }
        task.resume()
    }
}


class ParcelAPIService {
    
}
