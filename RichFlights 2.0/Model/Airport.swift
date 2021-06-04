//
//  Airport.swift
//  Rich's Flights
//
//  Created by Tendaishe Gwini on 13/12/2018.
//  Copyright © 2018 Tendaishe Gwini. All rights reserved.
//

import UIKit

class Airport: Equatable, Hashable {
    
    //MARK: Initializers
    
    init(airportCode: String, airportName: String, cityCode: String, cityName: String, countryName: String, countryCode: String, lat: String, lon: String) {
        
        self.id = airportCode
        self.airportCode = airportCode
        self.airportName = airportName
        self.cityCode = cityCode
        self.cityName = cityName
        self.countryName = countryName
        self.countryCode = countryCode
        self.lat = lat
        self.lon = lon
        
    }
    
    //MARK: Propeties
    
    let id: String
    let airportCode: String
    let airportName: String
    let cityCode: String
    let cityName: String
    let countryName: String
    let countryCode: String
    let lat: String
    let lon: String
    
    var displayText: String {
        get {
            return "\(cityName), \(countryName) (\(airportCode))"
        }
    }
    
    //MARK: Equatable Method Stubs
    
    static func == (lhs: Airport, rhs: Airport) -> Bool {
        return lhs.airportCode == rhs.airportCode
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    
    
}
