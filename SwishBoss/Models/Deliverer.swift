//
//  Deliverer.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

struct Deliverer: Codable {
    let id: Int
    let firstname: String
    let name: String
    let birthday: String
    let email: String
    let urlPhoto: String?
    let currentLatitude: Float
    let currentLongitude: Float
}
