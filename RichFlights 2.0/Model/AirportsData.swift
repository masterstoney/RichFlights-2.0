//
//  AirportsData.swift
//  Rich's Flights
//
//  Created by Tendaishe Gwini on 13/12/2018.
//  Copyright © 2018 Tendaishe Gwini. All rights reserved.
//

import UIKit

class AirportsData {
    
    
    //MARK: Initializers
    
    private init() {
        fetchData()
    }
    
    
    //MARK: Properties
    
    var data: [Airport] = []
    private var airportsDatabase = AirportsDatabaseManager()
    
    static let shared: AirportsData = AirportsData()
    
    //MARK: Methods
    
    private func fetchData() {
        airportsDatabase.connectDB()
        data = airportsDatabase.getAirportList()
    }
    
}
