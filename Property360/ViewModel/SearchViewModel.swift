//
//  SearchViewModel.swift
//  Property360
//
//  Created by Edmund Yu on 25/2/2022.
//

import Foundation

class SearchViewModel: ObservableObject {
//    @Published var cityKeyword = ""
//    @Published var radius = 1
//    @Published var minBedroom = 1
//    @Published var maxBedroom = 3
//    @Published var minPrice = 100000
//    @Published var maxPrice = 300000
//    @Published var outstandingSchool = 1
    
    @Published var location: String = ""
    @Published var minPrice = NumbersOnly()
    @Published var maxPrice = NumbersOnly()
    @Published var radius = NumbersOnly()
    
}
