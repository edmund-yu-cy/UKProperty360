//
//  Place.swift
//  Property360
//
//  Created by Edmund Yu on 15/2/2022.
//

import Foundation

struct Place: Decodable {
    let key: Int
    let externalKey: String
    let name: String
    let type: String
    let latitude: Double
    let longitude: Double
    let dateCreated: Date
    let vicinity: String
}
