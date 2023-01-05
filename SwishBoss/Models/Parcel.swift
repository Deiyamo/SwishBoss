//
//  Parcel.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

class Parcel {
    var uuid: String
    var deliveryAddress: Address
    var billAddress: Address
    var createdDate: Date
    var clientName: String
    
    init(uuid: String, deliveryAddress: Address, billAddress: Address, createdDate: Date, clientName: String) {
        self.uuid = uuid
        self.deliveryAddress = deliveryAddress
        self.billAddress = billAddress
        self.createdDate = createdDate
        self.clientName = clientName
    }
}
