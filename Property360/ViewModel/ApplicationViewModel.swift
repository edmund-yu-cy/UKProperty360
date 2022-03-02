//
//  Property360ViewModel.swift
//  Property360
//
//  Created by Edmund Yu on 16/2/2022.
//

import Foundation
import Alamofire
import SwiftUI

class ApplicationViewModel: ObservableObject {
    
    @Published var searchViewModel = SearchViewModel()
    @Published var propertyViewModel = PropertyViewModel()
    @Published var propertyListingViewModel = PropertyListingViewModel()
    @Published var propertyNotFound = false
    @Published var fetchingProperty = false
    @Published var showPropertyListing = false
    @Published var showPropertyDetails = false

    let dao = ApplicationDao()
    
//    func firstCall() {
//        fetchingProperty = true
//        dao.getProperty(key: 185, completion: { [self] result in
//            switch result {
//            case .failure(let error):
//                propertyNotFound = true
//                fetchingProperty = false
//            case .success(let property):
//                print("success")
//                propertyViewModel = populateProperty(property: property)
//                fetchingProperty = false
//            }
//        })
//    }
    
    func onPropertyTapped(property: Property) {
        propertyViewModel = populateProperty(property: property)
        showPropertyDetails = true
    }

    func searchProperties() {
        print("Location: \(searchViewModel.location)")
        print("Radius: \(searchViewModel.radius.value)")
        print("Min Price: \(searchViewModel.minPrice.value)")
        print("Max Price: \(searchViewModel.maxPrice.value)")
        
        searchCall()
    }
    
    func searchCall() {
        fetchingProperty = true
        dao.listProperties(cityKey: 60, radius: 4, completion: { [self] response in
            fetchingProperty = false
            switch response {
            case .failure(let error):
                print(error)
            case .success(let properties):
                let listingsViewModel = PropertyListingViewModel()
                listingsViewModel.properties = properties
                propertyListingViewModel = listingsViewModel
                showPropertyListing = true
            }
        })
    }
    
    func populateProperty(property: Property) -> PropertyViewModel {
        var viewModel = PropertyViewModel()
        viewModel.description = property.summary
        viewModel.bedrooms = property.bedrooms
        viewModel.bathrooms = property.bathrooms ?? 0
        viewModel.firstImageUrl = property.images.count == 0 ? "" : property.images[0].sourceUrl
        viewModel.imagesUrls = property.images.map { $0.sourceUrl }
        viewModel.address = property.address!
        viewModel.subType = property.subType!
        viewModel.price = Int(property.price)
        property.nearbySchools.forEach { nearbySchool in
            if nearbySchool.school.ratingValue == "1" {
                viewModel.outstandingRatingCounts += 1
                viewModel.nearbySchools.append(SchoolViewModel(name: nearbySchool.school.name, distance: nearbySchool.distance))
            } else if nearbySchool.school.ratingValue == "2" {
                viewModel.goodRatingCounts += 1
            } else if nearbySchool.school.ratingValue == "3" {
                viewModel.reqImprovementCounts += 1
            }
        }
        property.nearbyPlaces.forEach { nearbyPlace in
            switch nearbyPlace.place.type {
            case "supermarket":
                viewModel.nearbySupermarkets.append(PoiViewModel(name: nearbyPlace.place.name, distance: nearbyPlace.distanceInMeters, duration: nearbyPlace.durationByCarInMinutes))
                viewModel.nearbySupermarkets = viewModel.nearbySupermarkets.sorted(by: { $0.distance < $1.distance })
            case "train_station":
                viewModel.nearbyTrainStations.append(PoiViewModel(name: nearbyPlace.place.name, distance: nearbyPlace.distanceInMeters, duration: nearbyPlace.durationByCarInMinutes))
            case "park":
                viewModel.nearbyParks.append(PoiViewModel(name: nearbyPlace.place.name, distance: nearbyPlace.distanceInMeters, duration: nearbyPlace.durationByCarInMinutes))
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
        
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Shoplifting", count: nearbyShoplifting))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Bicycle Theft", count: nearbyBicycleTheft))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Anti Social Behaviour", count: nearbyAntiSocialBehaviour))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Drugs", count: nearbyDrugs))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Theft from the person", count: nearbyTheftFromThePerson))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Robbery", count: nearbyRobbery, colour: .red))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Violent Crime", count: nearbyViolentCrime, colour: .red))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Public Order", count: nearbyPublicOrder))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Burglary", count: nearbyBurglary, colour: .red))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Other Crime", count: nearbyOtherCrime))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Other Theft", count: nearbyOtherTheft))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Possession of Weapons", count: nearbyPossessionOfWeapons, colour: .red))
        viewModel.nearbyCrimeCounts.append(CrimeCountViewModel(type: "Criminal Damage Arson", count: nearbyCriminalDamageArson, colour:.red))
        
        return viewModel
    }
    

}
