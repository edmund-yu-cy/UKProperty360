//
//  PropertyImage.swift
//  Property360
//
//  Created by Edmund Yu on 15/2/2022.
//

import Foundation

struct PropertyImage: Decodable {
    let key: Int
    let sourceUrl: String
    let originalUrl: String
    let dateDownloaded: Date
}
