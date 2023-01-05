//
//  DeliveryTour.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

class DeliveryTour {
    var id: Int
    var deliverer: Deliverer
    var parcels: [Parcel]
    var deliveryDate: Date
    
    init(id: Int, deliverer: Deliverer, parcels: [Parcel], deliveryDate: Date) {
        self.id = id
        self.deliverer = deliverer
        self.parcels = parcels
        self.deliveryDate = deliveryDate
    }
}


extension DeliveryTour {
    class func fromDictionary(dict: [String: Any]) -> DeliveryTour? {
        guard let id = dict["title"] as? Int,
              let deliverer = dict["content"] as? Deliverer,
              let parcels = dict["createdDate"] as? [Parcel],
              let deliveryDateStr = dict["updatedDate"] as? String else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZ"
        guard let deliveryDate = dateFormatter.date(from: deliveryDateStr) else {
            return nil
        }
        return DeliveryTour(id: id, deliverer: deliverer, parcels: parcels, deliveryDate: deliveryDate)
    }
    
    func toDictionary() -> [String: Any] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZ"
        return [
            "id": self.id,
            "deliverer": self.deliverer,
            "parcels": self.parcels,
            "deliveryDate": dateFormatter.string(from: self.deliveryDate)
        ]
    }
}
