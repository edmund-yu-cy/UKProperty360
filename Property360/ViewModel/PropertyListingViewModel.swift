//
//  PropertyListingViewModel.swift
//  Property360
//
//  Created by Edmund Yu on 25/2/2022.
//

import Foundation

class PropertyListingViewModel: ObservableObject {
    
    @Published var properties = [Property]()
    @Published var selectedPropertyKey = 0

    
    
}
