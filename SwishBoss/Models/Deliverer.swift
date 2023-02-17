//
//  Deliverer.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

struct Deliverer: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let birthDate: String
    var password: String = ""
    let email: String
    let phone: String
    let profilePicture: Image
    let createdDate: Date
}
