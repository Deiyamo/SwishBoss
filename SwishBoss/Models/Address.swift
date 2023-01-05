//
//  Address.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

class Address {
    var num: String
    var street: String
    var city: String
    var zipCode: String
    var country: String
    
    init(num: String, street: String, city: String, zipCode: String, country: String) {
        self.num = num
        self.street = street
        self.city = city
        self.zipCode = zipCode
        self.country = country
    }
}
