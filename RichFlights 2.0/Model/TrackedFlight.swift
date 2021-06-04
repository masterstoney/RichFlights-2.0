//
//  TrackedFlight.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 4/29/21.
//

import Foundation

struct TrackedFlight {
    
    //MARK: Initializers
    
    init(flight_iata: String, flightDate: Date = Date()) {
        self.flight_iata = flight_iata
        self.flightDate = flightDate
    }
    
    //MARK: Properties
    
    /**IATA code for the flight e.g MU2557*/
    var flight_iata: String
    
    /**Read-only: Date of flight to be used by API for calls*/
    var flight_date: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"
            return dateFormatter.string(from: flightDate)
        }
    }
    
    /**Date of flight used locally by app*/
    var flightDate: Date
    
    //MARK: Methods
    
    
    
}
