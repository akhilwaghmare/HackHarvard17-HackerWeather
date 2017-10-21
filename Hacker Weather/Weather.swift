//
//  Weather.swift
//  Hacker Weather
//
//  Created by Akhil Waghmare on 10/20/17.
//  Copyright © 2017 AW Labs. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    var location: String
    var temperature: Int
    var precipChance: Float
    var imageUrl: String
    
//    init(location: String, temperature: Int, precipChance: Float, imageUrl: String) {
//        self.location = location
//        self.temperature = temperature
//        self.precipChance = precipChance
//        self.imageUrl = imageUrl
//    }
}
