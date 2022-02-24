//
//  City.swift
//  Property360
//
//  Created by Edmund Yu on 24/2/2022.
//

import Foundation

struct City: Decodable {
    let key: Int
    let name: String
    let fullName: String
    let country: String
    let latitude: Float
    let longitude: Float
}
