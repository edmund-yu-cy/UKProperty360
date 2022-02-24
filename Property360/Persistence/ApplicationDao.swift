//
//  ApplicationDao.swift
//  Property360
//
//  Created by Edmund Yu on 24/2/2022.
//

import Foundation
import Alamofire
import UIKit

class ApplicationDao {
    let apiUrl = "https://rightmove-api-java.herokuapp.com/api"
    let decoder = JSONDecoder()
    
    init() {
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getProperty(key: Int, completion: @escaping (Result<Property, Error>) -> Void) {
        AF.request(apiUrl + String(format: "/properties/%d", key))
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Property.self, decoder: decoder) { (response: AFDataResponse<Property>) in
                switch response.result {
                case .success(let property):
                    completion(.success(property))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func searchProperty() {
        
    }
    
    func listCities(name: String, completion: @escaping (Result<[City], Error>) -> Void) {
        let parameters: Parameters = [
            "name" : name
        ]
        
        AF.request(apiUrl + "/cities", method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: AFDataResponse<[City]>) in
                switch response.result {
                case .success(let cities):
                    completion(.success(cities))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func listProperties(cityKey: Int, radius: Float, completion: @escaping (Result<[Property], Error>) -> Void) {
        let parameters: Parameters = [
            "cityKey": cityKey,
            "radius": radius
        ]
        
        AF.request(apiUrl + "/properties", method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: AFDataResponse<[Property]>) in
                switch response.result {
                case .success(let properties):
                    completion(.success(properties))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}

