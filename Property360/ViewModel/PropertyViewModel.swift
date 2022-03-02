//
//  PropertyViewModel.swift
//  Property360
//
//  Created by Edmund Yu on 25/2/2022.
//

import Foundation
import SwiftUI

struct SchoolViewModel: Hashable {
    var name: String
    var distance: Double
}

struct PoiViewModel: Hashable {
    var name: String
    var distance: Double
    var duration: Int
}

struct CrimeCountViewModel: Hashable {
    var type: StringLiteralType
    var count: Int
    var colour: Color = .primary
}

struct PropertyViewModel {
    var description: String = ""
    var bedrooms: Int = 0
    var bathrooms: Int = 0
    var firstImageUrl: String = ""
    var address: String = ""
    var subType: String = ""
    var price: Int = 0
    var imagesUrls: [String] = []
    var outstandingRatingCounts = 0
    var goodRatingCounts = 0;
    var reqImprovementCounts = 0;
    var nearbySchools: [SchoolViewModel] = []
    var supermarketCounts = 0;
    var trainStationCounts = 0;
    var parkCounts = 0;
    var nearbySupermarkets: [PoiViewModel] = []
    var nearbyTrainStations: [PoiViewModel] = []
    var nearbyParks: [PoiViewModel] = []
    var nearbyCrimeCounts: [CrimeCountViewModel] = []
}
