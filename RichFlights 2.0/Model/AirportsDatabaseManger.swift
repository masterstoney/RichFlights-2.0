//
//  AirportsDatabaseManger.swift
//  Rich's Flights
//
//  Created by Tendaishe Gwini on 13/12/2018.
//  Copyright © 2018 Tendaishe Gwini. All rights reserved.
//

import UIKit
import SQLite3


class AirportsDatabaseManager {
    
    //MARK: Properties
    
    private var db: OpaquePointer?
    
    
    //MARK: Methods
    
    private func locateDB() -> String {
        //locate database directory
        
        let fileURL = Bundle.main.url(forResource: "airports", withExtension: "db")
        return fileURL!.absoluteString
        
    }
    
    private func openDB() -> OpaquePointer? {
        
        var dbPointer: OpaquePointer?
        
        if sqlite3_open(locateDB(), &dbPointer) == SQLITE_OK {
            print("Successfully opened connection to database at \(locateDB())")
            return dbPointer
        } else {
            print("Unable to open database")
            return dbPointer
        }
    }
    
    func connectDB() {
        db = openDB()
    }
    
    
    func getAirportList() -> [Airport] {
        
        var queryStatement: OpaquePointer?
        var airports = [Airport]()
        var airportCode = String()
        var airportName = String()
        var cityCode = String()
        var cityName = String()
        var countryName = String()
        var countryCode = String()
        var lat = String()
        var lon = String()
        
        let queryStatementString = "SELECT code, name, cityCode, cityName, countryName, countryCode, lat, lon from airports;"
        
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let col0 = sqlite3_column_text(queryStatement, 0)
                airportCode = String(cString: col0!)
                let col1 = sqlite3_column_text(queryStatement, 1)
                airportName = String(cString: col1!)
                let col2 = sqlite3_column_text(queryStatement, 2)
                cityCode = String(cString: col2!)
                let col3 = sqlite3_column_text(queryStatement, 3)
                cityName = String(cString: col3!)
                let col4 = sqlite3_column_text(queryStatement, 4)
                countryName = String(cString: col4!)
                let col5 = sqlite3_column_text(queryStatement, 5)
                countryCode = String(cString: col5!)
                let col6 = sqlite3_column_text(queryStatement, 6)
                lat = String(cString: col6!)
                let col7 = sqlite3_column_text(queryStatement, 7)
                lon = String(cString: col7!)
                
                let airport = Airport(airportCode: airportCode, airportName: airportName, cityCode: cityCode, cityName: cityName, countryName: countryName, countryCode: countryCode, lat: lat, lon: lon)
                airports.append(airport)
                
            }
        } else {
            print("SELECT statement could not be prepared.")
        }
        
        sqlite3_finalize(queryStatement)
        return airports
    }
    
    
    
}
