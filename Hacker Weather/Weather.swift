//
//  Weather.swift
//  Hacker Weather
//
//  Created by Akhil Waghmare on 10/20/17.
//  Copyright © 2017 AW Labs. All rights reserved.
//

import Foundation

// Struct containing information about weather at specific location
struct Weather: Decodable {
    var location: String
    var temperature: Int
    var precipChance: Float
    var humidity: Float
    var imageUrl: String
}
