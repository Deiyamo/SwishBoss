//
//  Parcel.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

struct Parcel: Codable {
    let uuid: String
    let deliveryAddress: Address
    let billAddress: Address
    let createdDate: Date
    let clientName: String
}
