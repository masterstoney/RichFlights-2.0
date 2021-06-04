//
//  SkypickerDataModel.swift
//  Rich's Flights
//
//  Created by Tendaishe Gwini on 06/03/2019.
//  Copyright © 2019 Tendaishe Gwini. All rights reserved.
//

import UIKit

class SkypickerDataModel: Codable {
    
    var data: [SkypickerTrip]?
    
}

class SkypickerTrip: Codable {
    
    var local_arrival = String()
    var utc_arrival = String()
    var airlines: [String] = []
    var baglimit = SkypickerLuggage()
    var booking_token = String()
    var cityFrom = String()
    var cityTo = String()
    var countryFrom = SkypickerCountry()
    var countryTo = SkypickerCountry()
    var local_departure = String()
    var utc_departure = String()
    var distance = Float()
    var duration = SkypickerDuration()
    var flyFrom = String()
    var flyTo = String()
    var has_airport_change = Bool()
    var price = Int()
    var route: [SkypickerRoute] = []
    var deep_link: String
    
}

class SkypickerLuggage: Codable {
    
    var hand_height: Int?
    var hand_length: Int?
    var hand_weight: Int?
    var hand_width: Int?
    var hold_weight: Int?
    
}


class SkypickerCountry: Codable {
    
    var code = String()
    var name = String()
    
}


class SkypickerDuration: Codable {
    
    var departure = Int()
    var returnTime = Int()
    var total = Int()
    
    private enum CodingKeys: String, CodingKey {
        case returnTime = "return"
        case departure
        case total
    }
    
}

class SkypickerRoute: Codable {
    
    var local_arrival = String()
    var utc_arrival = String()
    var airline = String()
    var cityFrom = String()
    var cityTo = String()
    var local_departure = String()
    var utc_departure = String()
    var equipment: String?
    var flight_no = Int()
    var flyFrom = String()
    var flyTo = String()
    var operating_carrier: String?
    
}





