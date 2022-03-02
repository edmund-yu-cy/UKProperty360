//
//  Property.swift
//  Property360
//
//  Created by Edmund Yu on 15/2/2022.
//

import Foundation

struct Property: Decodable, Hashable {
    static func == (lhs: Property, rhs: Property) -> Bool {
        lhs.key == rhs.key
    }
    
    let key: Int
    let externalKey: Int
    let bedrooms: Int
    let bathrooms: Int?
    let floorPlans: Int
    let summary: String
    let address: String?
    let countryCodes: String?
    let subType: String?
    let url: String?
    let latitude: Float
    let longitude: Float
    let price: Double
    
    let dateFirstVisibleOnline: Date?
    let dateImported: Date?
    let nearbyPlacesLastFetchedDate: Date?
    let nearbySchoolsLastFetchedDate: Date?
    let nearbyCrimesCountLastFetchedDate: Date?
    let nearbySchools: [NearbySchool]
    let nearbyPlaces: [NearbyPlace]
    let nearbyCrimesCounts: [NearbyCrimesCount]
    let images: [PropertyImage]

    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    /**

     */
}
