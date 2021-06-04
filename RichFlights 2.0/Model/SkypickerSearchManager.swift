//
//  SkypickerSearchManager.swift
//  Rich's Flights
//
//  Created by Tendaishe Gwini on 18/03/2019.
//  Copyright © 2019 Tendaishe Gwini. All rights reserved.
//

import UIKit

class SkypickerSearchManager {
    
    
    func search(trip: Trip, completion: @escaping (_ results: SkypickerDataModel, _ error: Error?) -> Void) {
        
        
        let returnDates = trip.returnTrip ? "&return_from=\(trip.returnDate)&return_to=\(trip.returnDate)" : ""
        
        let urlString = "https://tequila-api.kiwi.com/v2/search?fly_from=" + trip.source + "&fly_to=" + trip.destination + "&date_from=" + trip.departureDate + "&date_to=" + trip.departureDate + returnDates + "&adults=1&curr=USD"
        var skypickerData = SkypickerDataModel()
        let url = URL(string: urlString)!
        
        print(urlString)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("89g1RwJNoPy0OybR1J17QC8EC2C91DWy", forHTTPHeaderField: "apikey")
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                completion(skypickerData,error)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(SkypickerDataModel.self, from: data)
                    skypickerData = result
                } catch {
                    print(error)
                }
                completion(skypickerData,error)
            }
        }
        task.resume()
        
    }
    
    
    
    
    
    
}

