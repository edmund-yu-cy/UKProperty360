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
    var colour: Color = .black
}

class PropertyViewModel: ObservableObject {
    @Published var description: String = ""
    @Published var bedrooms: Int = 0
    @Published var bathrooms: Int = 0
    @Published var firstImageUrl: String = ""
    @Published var address: String = ""
    @Published var subType: String = ""
    @Published var price: Int = 0
    @Published var imagesUrls: [String] = []
    @Published var outstandingRatingCounts = 0
    @Published var goodRatingCounts = 0;
    @Published var reqImprovementCounts = 0;
    @Published var nearbySchools: [SchoolViewModel] = []
    @Published var supermarketCounts = 0;
    @Published var trainStationCounts = 0;
    @Published var parkCounts = 0;
    @Published var nearbySupermarkets: [PoiViewModel] = []
    @Published var nearbyTrainStations: [PoiViewModel] = []
    @Published var nearbyParks: [PoiViewModel] = []
    @Published var nearbyCrimeCounts: [CrimeCountViewModel] = []
}
