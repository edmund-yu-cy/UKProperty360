//
//  NearbyCrimesCount.swift
//  Property360
//
//  Created by Edmund Yu on 15/2/2022.
//

import Foundation

struct NearbyCrimesCount: Decodable {
    let key: Int
    let dateOccured: Date
    let shopLifting: Int
    let bicycleTheft: Int
    let antiSocialBehaviour: Int
    let drugs: Int
    let theftFromThePerson: Int
    let robbery: Int
    let violentCrime: Int
    let publicOrder: Int
    let burglary: Int
    let otherCrime: Int
    let otherTheft: Int
    let possessionOfWeapons: Int
    let criminalDamageArson: Int
}
