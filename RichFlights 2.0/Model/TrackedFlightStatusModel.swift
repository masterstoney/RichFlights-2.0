//
//  TrackedFlightStatusModel.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 4/29/21.
//

import Foundation

class TrackedFlightStatusModel {
    
    //MARK: Initializers
    
    init(data: AviationStackData? = nil) {
        self.data = data
    }
    
    //MARK: Properties
    
    var flightNo: String {
        get {
            guard let data = data else {return "UM00"}
            return data.flight.iata
        }
    }
    
    var departurePort: String {
        get {
            guard let data = data else {return "Dep"}
            return data.departure.iata
        }
    }
    
    var arrivalPort: String {
        get {
            guard let data = data else {return "Arr"}
            return data.arrival.iata
        }
    }
    
    var status: String {
        get {
            guard let data = data else {return "status"}
            return data.flight_status
        }
    }
    
    
    var eta: String {
        get {
            guard let data = data else {return "ETA"}
            guard let estimatedArrivalString = data.arrival.estimated else {return "???"}
            let correctedArrivalString = TrackedFlightStatusModel.utcCorrection(time: estimatedArrivalString)
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.timeZone = .current
            guard let localDate = dateFormatter.date(from: correctedArrivalString) else {return "???"}
            let relativeFormatter = RelativeDateTimeFormatter()
            let relativeDate = relativeFormatter.localizedString(for: localDate, relativeTo: Date())
            return relativeDate
        }
    }
    
    var data: AviationStackData?
    
    //MARK: Methods
    
    ///Corrects the time given by the Aviation Stack API to proper UTC format
    ///
     ///The Aviation Stack API gives the time of events in the timezone of where the account was registered. In this case its EDT (America/New_York). The problem is that they send the data in ISO8601 format with the time already adjusted to the timezone. When one uses the ISO8601DateFormatter to get the date from the string, the date that is returned will be wrong since the timezone information was scrubbed from the string given by the API. This method fixes the string from the API and restores the timezone data to the string.
     
     
    static func utcCorrection(time: String, timezone: String = "America/New_York") -> String {
        
        let iso8601TimeFormatter = ISO8601DateFormatter()
        iso8601TimeFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        guard let date = iso8601TimeFormatter.date(from: time) else {return ""}


        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents(in: TimeZone(secondsFromGMT: 0)!, from: date)
        components.timeZone = TimeZone(identifier: timezone)
        let correctedDate = calendar.date(from: components)!
        
        return iso8601TimeFormatter.string(from: correctedDate)
        
    }
    
}
