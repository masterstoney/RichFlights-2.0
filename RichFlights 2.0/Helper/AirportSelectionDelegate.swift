//
//  AirportSelectionDelegate.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/18/21.
//

import Foundation

protocol AirportSelectionDelegate: AnyObject {
    
    func selectedAirports(departure: Airport?, destination: Airport?)
    
}
