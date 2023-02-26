//
//  DeliveryTour.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

struct DeliveryTour: Codable {
    let id: Int
    let deliverer: Deliverer?
    let idDeliveryPerson: Int?
    let parcels: [Parcel]
    let date: String
    let state: String
}
