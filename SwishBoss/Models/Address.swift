//
//  Address.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation
import CoreLocation

struct Address: Codable {
    // let num: String
    let street: String
    let city: String
    let zipCode: String
    let country: String
}
