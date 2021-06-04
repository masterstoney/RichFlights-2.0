//
//  AviationStackManager.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 4/29/21.
//

import Foundation

class AviationStackManager {
    
    //MARK: Properties
    
    var mostRecentWidgetInfo: TrackedFlightStatusModel?
    
    
    //MARK: Methods
    
    func fetch(flightDetails: TrackedFlight, completion: @escaping (AviationStackDataModel?,Error?)->() ) {
        
        if flightDetails.flight_iata.isEmpty {
            completion(nil,nil)
            return
        }
        
        let urlString = "http://api.aviationstack.com/v1/flights?access_key=24ef0b2f1299db9218b9d885d25f46a6&flight_iata=\(flightDetails.flight_iata)"
        let url = URL(string: urlString)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(nil,error)
                return
            }
            
            do {

                let decoder = JSONDecoder()
                guard let data = data else {completion(nil,nil); return}
                
                let stackData = try decoder.decode(AviationStackDataModel.self, from: data)
                self.mostRecentWidgetInfo = TrackedFlightStatusModel(data: stackData.data.first)
                completion(stackData,nil)
            } catch {
                completion(nil,error)
            }
        }
        
        task.resume()
    }
    
    
    
    
    
    
    
    
    
}
