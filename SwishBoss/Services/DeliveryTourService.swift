//
//  DeliveryTourService.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

protocol DeliveryTourService {
    func add(deliveryTour: DeliveryTour, _ completion: @escaping (Error?) -> Void)
    func getAll(_ completion: @escaping (Error?, [DeliveryTour]?) -> Void)
    func getBy(id: Int, _ completion: @escaping (Error?, [DeliveryTour]?) -> Void)
    func getBy(delivererName: String, _ completion: @escaping (Error?, [DeliveryTour]?) -> Void)
    func update()
    func delete(id: Int, _ completion: @escaping (Error?) -> Void)
}
