//
//  Deliverer.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

struct Deliverer: Codable {
    let id: Int
    let uuid: String
    let login: String
    let firstname: String
    let name: String
    let birthday: String
    var password: Password?
    let email: String
    let urlPhoto: String?
    let currentLatitude: Float?
    let currentLongitude: Float?
}

struct Deliverers: Codable{
    let rowCount: Int
    let rows: [Deliverer]
}

struct Password: Codable{
    let type: String
    let data: [Int]
}
