//
//  Weather.swift
//  Hacker Weather
//
//  Created by Akhil Waghmare on 10/20/17.
//  Copyright © 2017 AW Labs. All rights reserved.
//

import Foundation

class Weather {
    var location: String
    var temperature: Int
    var precipChance: Float
    var imageUrlString: String
    
    init(location: String, temperature: Int, precipChance: Float, imageUrlString: String) {
        self.location = location
        self.temperature = temperature
        self.precipChance = precipChance
        self.imageUrlString = imageUrlString
    }
}
