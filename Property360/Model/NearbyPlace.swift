//
//  NearbyPlace.swift
//  Property360
//
//  Created by Edmund Yu on 15/2/2022.
//

import Foundation

struct NearbyPlace: Decodable {
    let key: Int
    let place: Place
    let distanceInMeters: Double
    let durationByCarInMinutes: Int
}
