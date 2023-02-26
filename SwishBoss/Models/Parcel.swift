//
//  Parcel.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

struct Parcel: Codable {
    let id: Int
    let uuid: UUID
    let addressStreet: String
    let town: String
    let zipCode: String
    let country: String
    let civility: String
    let firstname: String
    let lastname: String
    let phone: String?
    let email: String?
    let urlProofDelivered: String?
    var isDelivered: Bool
    var dateDelivered: String?
    let idTour: Int?
    var order: Int = 0
}
