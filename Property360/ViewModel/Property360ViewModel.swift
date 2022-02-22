//
//  Property360ViewModel.swift
//  Property360
//
//  Created by Edmund Yu on 16/2/2022.
//

import Foundation
import Alamofire
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

class Property360ViewModel: ObservableObject {
    
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
    
    func firstCall() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let request = AF.request("http://localhost:5000/api/properties/185")
        request.responseDecodable(of: Property.self, decoder: decoder) { [self] response in
            guard let property = response.value else { return }
            description = property.summary
            bedrooms = property.bedrooms
            bathrooms = property.bathrooms
            firstImageUrl = property.images[0].sourceUrl
            imagesUrls = property.images.map { $0.sourceUrl }
            address = property.address!
            subType = property.subType!
            price = Int(property.price)
            property.nearbySchools.forEach { nearbySchool in
                if nearbySchool.school.ratingValue == "1" {
                    outstandingRatingCounts += 1
                    nearbySchools.append(SchoolViewModel(name: nearbySchool.school.name, distance: nearbySchool.distance))
                } else if nearbySchool.school.ratingValue == "2" {
                    goodRatingCounts += 1
                } else if nearbySchool.school.ratingValue == "3" {
                    reqImprovementCounts += 1
                }
            }
            property.nearbyPlaces.forEach { nearbyPlace in
                switch nearbyPlace.place.type {
                case "supermarket":
                    nearbySupermarkets.append(PoiViewModel(name: nearbyPlace.place.name, distance: nearbyPlace.distanceInMeters, duration: nearbyPlace.durationByCarInMinutes))
                    nearbySupermarkets = nearbySupermarkets.sorted(by: { $0.distance < $1.distance })
                case "train_station":
                    nearbyTrainStations.append(PoiViewModel(name: nearbyPlace.place.name, distance: nearbyPlace.distanceInMeters, duration: nearbyPlace.durationByCarInMinutes))
                case "park":
                    nearbyParks.append(PoiViewModel(name: nearbyPlace.place.name, distance: nearbyPlace.distanceInMeters, duration: nearbyPlace.durationByCarInMinutes))
                default:
                    print("dfadfa")
                }
            }
            var nearbyShoplifting = 0;
            var nearbyBicycleTheft = 0;
            var nearbyAntiSocialBehaviour = 0;
            var nearbyDrugs = 0;
            var nearbyTheftFromThePerson = 0;
            var nearbyRobbery = 0;
            var nearbyViolentCrime = 0;
            var nearbyPublicOrder = 0;
            var nearbyBurglary = 0;
            var nearbyOtherCrime = 0;
            var nearbyOtherTheft = 0;
            var nearbyPossessionOfWeapons = 0;
            var nearbyCriminalDamageArson = 0;
            
            property.nearbyCrimesCounts.forEach { count in
                nearbyShoplifting += count.shopLifting
                nearbyBicycleTheft += count.bicycleTheft
                nearbyAntiSocialBehaviour += count.antiSocialBehaviour
                nearbyDrugs += count.drugs
                nearbyTheftFromThePerson += count.theftFromThePerson
                nearbyRobbery += count.robbery
                nearbyViolentCrime += count.violentCrime
                nearbyPublicOrder += count.publicOrder
                nearbyBurglary += count.burglary
                nearbyOtherCrime += count.otherCrime
                nearbyOtherTheft += count.otherTheft
                nearbyPossessionOfWeapons += count.possessionOfWeapons
                nearbyCriminalDamageArson += count.criminalDamageArson
            }
            
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Shoplifting", count: nearbyShoplifting))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Bicycle Theft", count: nearbyBicycleTheft))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Anti Social Behaviour", count: nearbyAntiSocialBehaviour))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Drugs", count: nearbyDrugs))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Theft from the person", count: nearbyTheftFromThePerson))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Robbery", count: nearbyRobbery, colour: .red))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Violent Crime", count: nearbyViolentCrime, colour: .red))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Public Order", count: nearbyPublicOrder))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Burglary", count: nearbyBurglary, colour: .red))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Other Crime", count: nearbyOtherCrime))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Other Theft", count: nearbyOtherTheft))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Possession of Weapons", count: nearbyPossessionOfWeapons, colour: .red))
            nearbyCrimeCounts.append(CrimeCountViewModel(type: "Criminal Damage Arson", count: nearbyCriminalDamageArson, colour:.red))
        }
    }
}
