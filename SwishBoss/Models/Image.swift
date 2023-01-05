//
//  Image.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import Foundation

class Image {
    var url: String
    var height: Int?
    var width: Int?
    
    init(url: String, height: Int?, width: Int?) {
        self.url = url
        self.height = height
        self.width = width
    }
}
