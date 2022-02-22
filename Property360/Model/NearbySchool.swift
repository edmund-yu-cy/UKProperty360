//
//  NearbySchool.swift
//  Property360
//
//  Created by Edmund Yu on 15/2/2022.
//

import Foundation

struct NearbySchool: Decodable {
    let key: Int
    let school: School
    let distance: Double
}
