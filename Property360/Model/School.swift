//
//  School.swift
//  Property360
//
//  Created by Edmund Yu on 15/2/2022.
//

import Foundation

struct School: Decodable {
    let key: Int
    let externalKey: Int
    let name: String
    let type: String
    let subType: String
    let religion: String
    let gender: String
    let pupilCount: Int?
    let maximumAge: Int
    let minimumAge: Int
    let ratingBody: String
    let ratingLabel: String
    let ratingValue: String
    let inspectionReportUrl: String?
    let unit: String
    let latitude: Double
    let longitude: Double
}
