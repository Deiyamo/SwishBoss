//
//  Deliverer.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

class Deliverer {
    var id: Int
    var firstName: String
    var lastName: String
    var birthDate: String
    var password: String = ""
    var email: String
    var phone: String
    var profilePicture: Image
    var createdDate: Date
    
    init(id: Int, firstName: String, lastName: String, birthDate: String, password: String, email: String, phone: String, profilePicture: Image, createdDate: Date) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.password = password
        self.email = email
        self.phone = phone
        self.profilePicture = profilePicture
        self.createdDate = createdDate
    }
}
